const express = require('express');
const path = require('path');
const admin = require('firebase-admin');
const app = express();
const port = 3000;

const serviceAccount = require('./enquire-fdc88-firebase-adminsdk-je4it-3ada0db987.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
module.exports = { db };
app.use(express.json());
app.use(express.static(path.join(__dirname)));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/get-events', async (req, res) => {
  try {
    const eventsSnapshot = await db.collection('event').where('quiz', '==', true).get();
    const events = eventsSnapshot.docs.map(doc => {
      const eventData = doc.data();
      const eventDate = eventData.date.toDate();
      const formattedDate = `${eventDate.getDate()}-${eventDate.getMonth() + 1}-${eventDate.getFullYear()}`;
      return {
        id: doc.id,
        title: eventData.title,
        date: formattedDate
      };
    });

    res.json({ events });
  } catch (error) {
    console.error('Error fetching events:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/get-users', async (req, res) => {
  const { eventId } = req.body;

  try {
    const usersSnapshot = await db.collection('event').doc(eventId).collection('quiz_completed').get();
    const userEmails = usersSnapshot.docs.map(doc => doc.id);

    res.json({ userEmails });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/get-answers', async (req, res) => {
  const { eventId, userEmail } = req.body;

  try {
    const userDoc = db.collection('event').doc(eventId).collection('quiz_completed').doc(userEmail);
    const userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      return res.status(404).json({ message: 'User not found.' });
    }

    const userData = userSnapshot.data();
    const userAnswers = userData.useranswers;

    res.json({ userAnswers });
  } catch (error) {
    console.error('Error fetching answers:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/add-event', async (req, res) => {
  const { title, date, time, details, img, instruct, quiz, questions } = req.body;

  try {
    
    const eventRef = await db.collection('event').add({
      title,
      date: new Date(date),
      time,
      details,
      img,
      instruct,
      quiz,
    });

    const eventId = eventRef.id;

    if (quiz && questions && questions.length > 0) {
      const questionsPromises = questions.map(q => 
        db.collection('event').doc(eventId).collection('questions').add(q)
      );
      await Promise.all(questionsPromises);
    }

    res.json({ message: 'Event added successfully' });
  } catch (error) {

    console.error('index js error:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});


app.post('/validate-answers', async (req, res) => {
  const { eventId, userEmail, correctAnswers } = req.body;

  try {
    const userDoc = db.collection('event').doc(eventId).collection('quiz_completed').doc(userEmail);
    const userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      return res.status(404).send('User not found.');
    }

    const userData = userSnapshot.data();
    const userAnswers = userData.useranswers;
    const eventDate = (await db.collection('event').doc(eventId).get()).data().date.toDate();
    const eventTitle = (await db.collection('event').doc(eventId).get()).data().title;
    const formattedDate = `${eventDate.getDate()}-${eventDate.getMonth() + 1}-${eventDate.getFullYear()}`;
    const userQuizDocId = `${eventTitle} ${formattedDate}`;
    let score = 0;
    for (let i = 0; i < userAnswers.length; i++) {
      if (correctAnswers[i]) {
        score++;
      }
    }


    await userDoc.update({ score });

    const userQuizDoc = db.collection('users').doc(userEmail).collection('quizzes').doc(userQuizDocId);
    await userQuizDoc.update({ score });

    res.send('Score updated successfully.');
  } catch (error) {
    console.error('Error validating answers:', error);
    res.status(500).send('Internal Server Error');
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
