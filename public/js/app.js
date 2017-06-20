(function() {
  document.getElementById('name-form').addEventListener('submit', handleGetName);

  function handleGetName(ev) {
    var value = document.getElementById('player-name').value;
    var isValid = !!value;

    if(!isValid) {
      document.getElementById('name-validate').style.display = 'block';
      ev.preventDefault();
    } else {
      document.getElementById('name-validate').style.display = 'none';
    }
  }
})()