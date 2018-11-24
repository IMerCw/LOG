package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.NoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService{
	
	@Resource(name="NoticeMapper")
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeDTO> getNotification(String user_seq) throws Exception {
		return noticeMapper.getNotification(user_seq);
	}

	@Override
	public int getNoticeCount(String user_seq) throws Exception {
		return noticeMapper.getNoticeCount(user_seq);
	}

	@Override
	public List<NoticeDTO> getNotificationSummary(String user_seq) throws Exception {
		return noticeMapper.getNotificationSummary(user_seq);
	}
	
}
