(function() {
  document.getElementById('guess-form').addEventListener('submit', handleAttempt);
  document.getElementById('hint').addEventListener('click', handleClick)

  function handleAttempt(ev) {
    document.querySelector('.hint-msg').style.display = 'none';
    var value = document.getElementById('guess-input').value;
    var isValid = /^[1-6]{4}$/.test(value);

    if(!isValid) {
      document.getElementById('guess-validate').style.display = 'block';
      ev.preventDefault();
    } else {
      document.getElementById('guess-validate').style.display = 'none';
    }
  }

  function handleClick(ev) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/hint', true);
    xhr.send();

    xhr.onreadystatechange = function() {
      if (xhr.readyState != 4) return;

      if (xhr.status == 200) {
        document.getElementById('hint-number').innerHTML = xhr.responseText;
        document.querySelector('.hint-msg').style.display = 'block';
      }
    }
  }
})()