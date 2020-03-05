package com.board.repository;

import java.util.HashMap;

import com.board.mapper.MemberMapper;
import com.board.vo.Member;

public class MemberRepositoryImpl implements MemberRepository{
	private MemberMapper memberMapper;

	public MemberMapper getMemberMapper() {
		return memberMapper;
	}

	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Override
	public void insertMember(Member member) {
		
		memberMapper.insertMember(member);
		
	}

	@Override
	public Member selectMemberByIdAndPasswd(String id, String pwd) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("pwd", pwd);
		
		Member member = memberMapper.selectMemberByIdAndPasswd(params);
		
		return member;
	}

}
