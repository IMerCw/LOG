package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.NoticeDTO;

@Mapper("NoticeMapper")
public interface NoticeMapper {

	List<NoticeDTO> getNotification(String user_seq) throws Exception;

	int getNoticeCount(String user_seq) throws Exception;

	List<NoticeDTO> getNotificationSummary(String user_seq) throws Exception;

	
}
