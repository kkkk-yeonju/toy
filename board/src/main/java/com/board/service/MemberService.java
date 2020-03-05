package com.board.service;

import com.board.vo.Member;

public interface MemberService {

	void insertMember(Member member);

	Member selectMemberByIdAndPasswd(String id, String pwd);

}
