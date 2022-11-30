package com.web.admin.model.service;

import java.sql.Connection;
import java.util.List;

import static com.web.common.JDBCTemplate.getConnection;
import static com.web.common.JDBCTemplate.close;
import com.web.admin.model.dao.AdminDao;
import com.web.member.model.vo.Member;

public class AdminService {
	AdminDao dao=new AdminDao();
	
	
	public List<Member> searchMemberAll() {
		Connection conn=getConnection();
		List<Member> list=dao.searchMemberAll(conn);
		
		close(conn);
		return list;
		
	}
}
