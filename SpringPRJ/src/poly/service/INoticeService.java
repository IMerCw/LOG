package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;

public interface INoticeService {

	List<NoticeDTO> getNotification(String user_seq) throws Exception;

	int getNoticeCount(String user_seq) throws Exception;

	List<NoticeDTO> getNotificationSummary(String user_seq) throws Exception;

}
