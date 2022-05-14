function getUpdateXML() {
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            let data = xhr.responseXML;

            //Convert to objects
            let channel = {
                "title": data.getElementsByTagName('title')[0].textContent,
                "link": data.getElementsByTagName('link')[0].textContent,
                "description": data.getElementsByTagName('description')[0].textContent
            };
            
            let items = {}
            const xmlItems = data.getElementsByTagName('item');

            for (let i = 0; i < xmlItems.length; i++) {
                items[i] = {
                    "title": xmlItems[i].getElementsByTagName('title')[0].textContent,
                    "link": xmlItems[i].getElementsByTagName('link')[0].textContent,
                    "description": xmlItems[i].getElementsByTagName('description')[0].textContent
                }
            }

            //Populate HTML
            const dom = document.getElementById('xml');
            dom.innerHTML = '';
            const headDiv = document.createElement('div');

            const head = document.createElement('h2');
            head.innerHTML = channel.title;
            head.setAttribute('href', channel.link);

            const headContent = document.createElement('p');
            headContent.innerHTML = channel.description;

            headDiv.appendChild(head);
            headDiv.appendChild(headContent);

            dom.appendChild(headDiv);

            for (let i = 0; i < xmlItems.length; i++) {
                
                const newDiv = document.createElement('div');

                const heading = document.createElement('h3');
                heading.innerHTML = items[i].title;
                heading.setAttribute('href', items[i].link);

                const content = document.createElement('p');
                content.innerHTML = items[i].description;

                newDiv.appendChild(heading);
                newDiv.appendChild(content);

                dom.appendChild(newDiv);
            }
        }
    }

    xhr.open('GET','update.rss');
    xhr.send();
}

function getUpdateJSON() {
    xhr2 = new XMLHttpRequest();
    xhr2.onreadystatechange = function() {
        if (xhr2.readyState === 4 && xhr2.status === 200) {
            const data = JSON.parse(xhr2.responseText);

            //Populate HTML
            const dom = document.getElementById('json');
            dom.innerHTML = '';
            const headDiv = document.createElement('div');

            const head = document.createElement('h2');
            head.innerHTML = data.title;
            head.setAttribute('href', data.link);

            const headContent = document.createElement('p');
            headContent.innerHTML = data.description;

            headDiv.appendChild(head);
            headDiv.appendChild(headContent);

            dom.appendChild(headDiv);

            for (let i = 0; i < data.items.length; i++) {
                
                const newDiv = document.createElement('div');
                newDiv.setAttribute('class', 'jsonDiv');

                const heading = document.createElement('h3');
                heading.innerHTML = data.items[i].title;
                heading.setAttribute('href', data.items[i].link);

                const date = document.createElement('p');
                date.innerHTML = data.items[i].pubDate;
                date.setAttribute('class', 'date');

                const content = document.createElement('p');
                content.innerHTML = data.items[i].description;

                const author = document.createElement('p');
                author.innerHTML = data.items[i].author;
                author.setAttribute('class', 'author');

                newDiv.appendChild(heading);
                newDiv.appendChild(date);
                newDiv.appendChild(content);
                newDiv.appendChild(author);

                dom.appendChild(newDiv);
            }
        }
    }

    xhr2.open('GET','update.json');
    xhr2.send();
}

function get() {
    getUpdateXML();
    getUpdateJSON();
}

window.setInterval(get,1000);