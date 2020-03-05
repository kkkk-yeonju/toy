package com.board.mapper;

import java.util.HashMap;

import com.board.vo.Member;

//이 인터페이스의 패키지와 인터페이스 이름은 member-mapper.xml 파일의 namespace와 일치
public interface MemberMapper {

	void insertMember(Member member);

	Member selectMemberByIdAndPasswd(HashMap<String, Object> params);

}
