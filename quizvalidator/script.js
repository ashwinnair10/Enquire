async function fetchEvents() {
    const response = await fetch('/get-events', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    });

    const data = await response.json();

    if (response.ok) {
        const eventList = document.getElementById('eventList');
        eventList.innerHTML = '';
        data.events.forEach(event => {
            const div = document.createElement('div');
            div.className = 'menu-item';
            div.textContent = `${event.title} ${event.date}`;
            div.dataset.eventId = event.id;
            div.addEventListener('click', fetchUsers);
            eventList.appendChild(div);
        });
    } else {
        document.getElementById('result').innerText = data.message;
    }
}

async function fetchUsers(event) {
    const eventId = event.target.dataset.eventId;

    const response = await fetch('/get-users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ eventId })
    });

    const data = await response.json();

    if (response.ok) {
        const userList = document.getElementById('userList');
        userList.innerHTML = '';
        data.userEmails.forEach(email => {
            const div = document.createElement('div');
            div.className = 'menu-item';
            div.textContent = email;
            div.dataset.eventId = eventId;
            div.dataset.userEmail = email;
            div.addEventListener('click', fetchAnswers);
            userList.appendChild(div);
        });
    } else {
        document.getElementById('result').innerText = data.message;
    }
}

async function fetchAnswers(event) {
    const eventId = event.target.dataset.eventId;
    const userEmail = event.target.dataset.userEmail;

    const response = await fetch('/get-answers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ eventId, userEmail })
    });

    const data = await response.json();

    if (response.ok) {
        document.getElementById('answersList').innerHTML = data.userAnswers.map((answer, index) => `
            <div>
                <label for="answer${index}">Answer ${index + 1}:</label>
                <input type="text" id="answer${index}" value="${answer}" disabled>
                <input type="checkbox" id="correct${index}"> Correct
            </div>
        `).join('');

        document.getElementById('answersSection').style.display = 'block';
        document.getElementById('submitScores').dataset.eventId = eventId;
        document.getElementById('submitScores').dataset.userEmail = userEmail;
    } else {
        document.getElementById('result').innerText = data.message;
    }
}

document.getElementById('submitScores').addEventListener('click', async () => {
    const eventId = document.getElementById('submitScores').dataset.eventId;
    const userEmail = document.getElementById('submitScores').dataset.userEmail;

    const userAnswers = Array.from(document.querySelectorAll('#answersList input[type="text"]')).map(input => input.value);
    const correctAnswers = Array.from(document.querySelectorAll('#answersList input[type="checkbox"]')).map(checkbox => checkbox.checked);

    const response = await fetch('/validate-answers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ eventId, userEmail, userAnswers, correctAnswers })
    });

    const result = await response.text();
    document.getElementById('result').innerText = result;
});


fetchEvents();
