package com.board.repository;

import com.board.vo.Member;

public interface MemberRepository {

	void insertMember(Member member);

	Member selectMemberByIdAndPasswd(String id, String pwd);

}
