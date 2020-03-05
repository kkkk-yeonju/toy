package com.board.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.board.vo.Member;

public class CommentHandler extends TextWebSocketHandler {
	//로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<>();
	//1:1
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	
	//커넥션이 연결됐을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished:" + session);
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
	}
	
	//소켓에 메세지를 보냈을때 
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage:" + session + " : " + message);
//		String senderId = getId(session);
//		for(WebSocketSession sess: sessions) {
//			sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
//		}
		
		//protocol: cmd, 댓글작성자, 게시글작성자, boardno (comment,user2,user1,17)
		String msg = message.getPayload(); // 메시지에 담긴 텍스트값을 얻을 수 있음
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			
			if (strs != null && strs.length == 4) {
				String cmd = strs[0];
				String commentWriter = strs[1];
				String boardWriter = strs[2];
				String boardno = strs[3];
				
				//게시글작성자가 로그인해서 있다면
				WebSocketSession boardWriterSession = userSessions.get(boardWriter);
				if ("comment".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(commentWriter + "님이 "
							+ "<a href='/board/detail/boardno=" + boardno + "'>" + boardno + "</a>번 게시글에 댓글을 달았습니다!");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
		
	}

	//웹소켓 id 가져오기
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member loginUser = (Member)httpSession.get("loginuser");
		
		if(loginUser == null)
			return session.getId();
		else 
			return loginUser.getId();
	}

	//커넥션이 closed됐을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionEstablished:" + session + ":" + status);
		
		userSessions.remove(session.getId());
		sessions.remove(session);
	}

}
