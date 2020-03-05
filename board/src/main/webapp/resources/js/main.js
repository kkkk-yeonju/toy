//home.jsp 검색
$(function() {
		$('#search').on('click', function(event){
			//serialize() : <form>안에 포함된 입력 요소의 값을 이름=값&이름=값&...형식으로 만드는 함수 
			var keyword = $('#keyword').val();

			$.ajax({
				url: "/board/search",
				method: "get",
				data: "keyword=" + keyword,
				success: function(data, status, xhr){
					$('#board').load('/board/board-list',
									{"keyword" : keyword},
									function() {})
				},
				error: function(xhr, status, err){
					alert(err);
				} 
			});
		});
		
		
		//알림 읽기
		$('#alarm_content').on('click', '#alarm', function(event){
			var alarmno = $('#alarm_content').attr('data-alarmno');

			$.ajax({
				url: "/board/readAlarm",
				method: "POST",
				data: {alarmNo : alarmno},
				success: function(data, status, xhr){
					console.log(data);
				},
				error: function(xhr, status, err){
					alert(err);
				} 
			});
		});
		
});



