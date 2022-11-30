package com.web.admin.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.web.member.model.dao.MemberDao;
import com.web.member.model.vo.Member;
import static com.web.common.JDBCTemplate.close;

public class AdminDao {
	
	Properties sql=new Properties();
	public AdminDao() {
		 try {
	         String path=MemberDao.class.getResource("/sql/admin/adminsql.properties").getPath();
	         sql.load(new FileReader(path));
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	}
	
	public List<Member> searchMemberAll(Connection conn){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchMemberAll"));
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(new MemberDao().getMember(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
			
		}
		return list;
	}
	
	
//	private Member getMember(ResultSet rs) throws SQLException{
//	      return Member.builder()
//	            .userId(rs.getString("userid"))
//	            .password(rs.getString("password"))
//	            .userName(rs.getString("username"))
//	            .gender(rs.getString("gender").charAt(0))
//	            .age(rs.getInt("age"))
//	            .email(rs.getString("email"))
//	            .phone(rs.getString("phone"))
//	            .address(rs.getString("address"))
//	            .hobby(rs.getString("hobby").split(","))
//	            .enrollDate(rs.getDate("enrolldate"))
//	            .build();
//	   }
}
