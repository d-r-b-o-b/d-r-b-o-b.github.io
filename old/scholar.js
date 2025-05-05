async function fetchPublications() {
    const response = await fetch('https://api.google.com/scholar?user=4LxikSIAAAAJ');
    const publications = await response.json();
    const container = document.getElementById('publications');
    publications.forEach(pub => {
        const pubElement = document.createElement('div');
        pubElement.innerHTML = `<h3>${pub.title}</h3><p>${pub.authors}</p><p>${pub.year}</p>`;
        container.appendChild(pubElement);
    });
}

document.addEventListener('DOMContentLoaded', fetchPublications);


