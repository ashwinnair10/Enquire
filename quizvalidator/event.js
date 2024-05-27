// Define the addQuestion function
function addQuestion() {
    const questionsContainer = document.getElementById('questionsContainer');

    // Create new input elements for the question and answer
    const questionInput = document.createElement('input');
    questionInput.type = 'text';
    questionInput.id = `question${questionsContainer.children.length}`;
    questionInput.name = 'question';
    questionInput.placeholder = 'Enter question';
    questionsContainer.appendChild(questionInput);

    const answerInput = document.createElement('input');
    answerInput.type = 'text';
    answerInput.id = `answer${questionsContainer.children.length - 1}`; // Subtracting 1 because we added a question input first
    answerInput.name = 'answer';
    answerInput.placeholder = 'Enter answer';
    questionsContainer.appendChild(answerInput);
}

// Add an event listener to the form submission
document.getElementById('eventForm').addEventListener('submit', async (event) => {
    event.preventDefault();

    // Retrieve event details from the form
    const title = document.getElementById('title').value;
    const date = document.getElementById('date').value;
    const time = parseInt(document.getElementById('time').value);
    const details = document.getElementById('details').value;
    const img = document.getElementById('img').value;
    const instruct = document.getElementById('instruct').value;
    const quiz = document.getElementById('quiz').checked;

    // Construct an array of event questions and answers
    const questions = [];
    const questionInputs = document.querySelectorAll('[id^="question"]');
    const answerInputs = document.querySelectorAll('[id^="answer"]');
    questionInputs.forEach((questionInput, index) => {
        const question = questionInput.value;
        const answer = answerInputs[index].value;
        questions.push({ question, answer });
    });

    try {
        // Add the event to Firestore
        const eventRef = await db.collection('event').add({
            title,
            date: new Date(date),
            time,
            details,
            img,
            instruct,
            quiz,
            questions
        });

        // Display a success message
        document.getElementById('result').innerText = 'Event added successfully';
    } catch (error) {
        // Handle errors
        console.error('Error adding event:', error);
        document.getElementById('result').innerText = 'Error adding event';
    }
});
