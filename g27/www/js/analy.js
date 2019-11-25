<script>
	
	document.getElementById("demo0").onclick = function(){
		initMap();
	}
	document.getElementById("demo1").onclick = function(){
		initMap1();
	}
	document.getElementById("demo2").onclick = function(){
		initMap2();
	}
	document.getElementById("demo3").onclick = function(){
		initMap3();
	}
	document.getElementById("demo4").onclick = function(){
		initMap4();
	}
	document.getElementById("demo5").onclick = function(){
		initMap5();
	}
	document.getElementById("demo6").onclick = function(){
		initMap6();
	}
	document.getElementById("demo7").onclick = function(){
		initMap7();
	}
	document.getElementById("demo8").onclick = function(){
		initMap8();
	}
	document.getElementById("demo9").onclick = function(){
		initMap9();
	}
	
	var customLabel = {
        fixed: {
          label: 'F'
        },
        mobile: {
          label: 'M'
        }
      };
	  
	  marker.addListener('click', function() {
  infoWindow.setContent(infowincontent);
  infoWindow.open(map, marker);
});

//Sydney
function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(-33.863276, 151.207977),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
	
// Chicago Initialize and add the map
function initMap1() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(41.869361, -87.660712),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump1.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//London		
function initMap2() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(51.507489, -0.127957),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump2.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Tokyo	
function initMap3() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(35.680553, 139.769253),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump3.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Paris
function initMap4() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(48.8566, 2.3522),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump4.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Rome
function initMap5() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(41.9028, 12.4964),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump5.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Dubai
function initMap6() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(25.2048, 55.2708),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump6.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Cape Town
function initMap7() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(-33.9249, 18.4241),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump7.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//Los Angeles
function initMap8() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(34.0522, -118.2437),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump8.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
//West Lafayette
function initMap9() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(40.4259, -86.9081),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump9.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

function downloadUrl(url,callback) {
 var request = window.ActiveXObject ?
     new ActiveXObject('Microsoft.XMLHTTP') :
     new XMLHttpRequest;

 request.onreadystatechange = function() {
   if (request.readyState == 4) {
     request.onreadystatechange = doNothing;
     callback(request, request.status);
   }
 };

 request.open('GET', url, true);
 request.send(null);
}


function doNothing() {}

</script>