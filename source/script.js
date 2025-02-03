document.getElementById('weatherForm').addEventListener('submit', function (e) {
  e.preventDefault();

  const location = document.getElementById('location').value;
  const time = document.getElementById('time').value;

  // Replace with your API Gateway endpoint
  const apiGatewayUrl = 'https://kf0hefjjo9.execute-api.ap-southeast-1.amazonaws.com/dev/weather';

  // Call API Gateway instead of OpenWeatherMap directly
  fetch(`${apiGatewayUrl}?location=${encodeURIComponent(location)}`)
    .then((response) => response.json())
    .then((data) => {
      const weatherResult = document.getElementById('weatherResult');
      if (data.cod === 200) {
        weatherResult.innerHTML = `
          <h2>Weather in ${data.name}</h2>
          <p><strong>Temperature:</strong> ${data.main.temp}°C</p>
          <p><strong>Weather:</strong> ${data.weather[0].description}</p>
          <p><strong>Humidity:</strong> ${data.main.humidity}%</p>
          <p><strong>Wind Speed:</strong> ${data.wind.speed} m/s</p>
          ${time ? `<p><strong>Time:</strong> ${time}</p>` : ''}
        `;
      } else {
        weatherResult.innerHTML = `<p class="error">Location not found. Please try again.</p>`;
      }
    })
    .catch((error) => {
      console.error('Error:', error);
      weatherResult.innerHTML = `<p class="error">An error occurred. Please try again.</p>`;
    });
});