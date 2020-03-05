<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/board/resources/js/main.js"></script>
<script>
//전역변수 선언 - 모든 페이지에서 사용할 수 있게 footer.jsp에 저장
var socket = null;

$(document).ready(function(){
	connectWs();


	$(".bell").click(function() {
		$("#divToggle").toggle();
		});

});

	function connectWs() {
		console.log("----webSocket----");
		var ws = new WebSocket("ws://localhost:8088/board/commentWs");
		socket = ws;

		ws.onopen = function() {
			console.log('Info: connection opened.');
		};

		ws.onmessage = function(event) {
			var data = event.data;
			console.log("ReceiveMessage:", data + '\n');
			let $socketAlert = $('#socketAlert');
			$socketAlert.html(data);
			$socketAlert.css('display', 'block');

			setTimeout(function() {
				$socketAlert.css('display', 'none');
			}, 3000);

			$.ajax({
				url : '/board/countAlarm',
				type : 'POST',
				dataType : 'text',
				success : function(data) {
					if (data == '0') {
					} else {
						$('#alarmCount').addClass('alarm_bedge');
						$('#alarmCount').text(data);
					}
				},
				error : function(err) {
					alert('err');
				}
			});
		};

		ws.onclose = function(event) {
			console.log('Info: connection closed.');
			//setTimeout( function(){ connect(); }, 1000 ); // retry connection!!
		};

		ws.onerror = function(err) {
			console.log('Error:', err);
		};

	}
</script>
</body>
</html>