let xhr = new XMLHttpRequest();
xhr.open('GET', 'pubdate');
xhr.onload = function() {
  if (xhr.status === 200) {
    let pubdate = document.getElementById("pubdate");
    pubdate.innerHTML = "Last published: " + xhr.responseText;
    pubdate.style.display = "block";
  }
  else {
    // I don't care
  }
};
xhr.send();
