// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:load', () => {
    document.addEventListener('click', (event) => {
      const element = event.target.closest('form[data-turbo-method]');
      if (element) {
        event.preventDefault();
        const method = element.dataset.turboMethod;
        const url = element.action;
        
        fetch(url, {
          method: method.toUpperCase(),
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Accept': 'text/vnd.turbo-stream.html'
          },
          credentials: 'same-origin'
        }).then(response => {
          if (response.ok) {
            return response.text();
          }
          throw new Error('Network response was not ok.');
        }).then(html => {
          Turbo.renderStreamMessage(html);
        }).catch(error => {
          console.error('Error:', error);
        });
      }
    });
  });
