package com.board.service;

import com.board.common.Util;
import com.board.repository.MemberRepository;
import com.board.vo.Member;

public class MemberServiceImpl implements MemberService {
	private MemberRepository memberRepository;
	
	public MemberRepository getMemberRepository() {
		return memberRepository;
	}


	public void setMemberRepository(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	@Override
	public void insertMember(Member member) {
		
		String pwd = Util.getHashedString(member.getPwd(), "SHA-256"); //패스워드 암호화 (복원불가능)
		member.setPwd(pwd); 
		
		memberRepository.insertMember(member);
		
	}

	@Override
	public Member selectMemberByIdAndPasswd(String id, String pwd) {
		
		pwd = Util.getHashedString(pwd, "SHA-256");
		Member member = memberRepository.selectMemberByIdAndPasswd(id, pwd);
		
		return member;
	}

}
