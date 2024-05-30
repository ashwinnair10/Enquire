function addQuestion() {
    const questionsContainer = document.getElementById('questionsContainer');

    const questionInput = document.createElement('input');
    questionInput.type = 'text';
    questionInput.id = `question${questionsContainer.children.length}`;
    questionInput.name = 'question';
    questionInput.placeholder = 'Enter question';
    questionsContainer.appendChild(questionInput);

    const answerInput = document.createElement('input');
    answerInput.type = 'text';
    answerInput.id = `answer${questionsContainer.children.length - 1}`;
    answerInput.name = 'answer';
    answerInput.placeholder = 'Enter answer';
    questionsContainer.appendChild(answerInput);
}

document.getElementById('eventForm').addEventListener('submit', async (event) => {
    event.preventDefault();

    const title = document.getElementById('title').value;
    const date = document.getElementById('date').value;
    const time = parseInt(document.getElementById('time').value);
    const details = document.getElementById('details').value;
    const img = document.getElementById('img').value;
    const instruct = document.getElementById('instruct').value;
    const quiz = document.getElementById('quiz').checked;

    const questions = [];
    const questionInputs = document.querySelectorAll('[id^="question"]');
    const answerInputs = document.querySelectorAll('[id^="answer"]');
    questionInputs.forEach((questionInput, index) => {
        const question = questionInput.value;
        const answer = answerInputs[index].value;
        questions.push({ question, answer });
    });

    try {
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
        document.getElementById('result').innerText = 'Event added successfully';
    } catch (error) {
       
        console.error('event js error:', error);
        document.getElementById('result').innerText = 'Error adding event';
    }
});
