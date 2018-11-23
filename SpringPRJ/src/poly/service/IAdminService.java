package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.ImageDTO;
import poly.dto.KakaoUserDTO;
import poly.dto.UserMemberDTO;
import poly.dto.pageParamsDTO;

public interface IAdminService {

	List<UserMemberDTO> getAllUser(pageParamsDTO pDTO) throws Exception;

	int updateUser(UserMemberDTO updatedUDTO) throws Exception;

	List<UserMemberDTO> getSearchUser(String searchContent) throws Exception;

	int getTotalMemberListCount(String searchContent) throws Exception;

}
