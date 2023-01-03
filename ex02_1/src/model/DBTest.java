package model;

import java.util.ArrayList;

public class DBTest {

	public static void main(String[] args) {
		UserDAO dao=new UserDAO();
		ArrayList<UserVO> array=dao.list(2);
		for(UserVO vo:array) {
			System.out.println(vo.toString());
		}
	}

}
