package dendy.rpms.service;

import dendy.rpms.domain.AttaEntity;
import dendy.rpms.domain.ExaminationEntity;
import dendy.rpms.entity.Atta;
import dendy.rpms.entity.Examination;
import dendy.rpms.page.Pager;
import dendy.rpms.query.ExamQuery;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/9/13.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public interface IExamService {
    Examination get(Long id);

    void add(Examination examination);

    void update(Examination examination);

    void delete(String ids);

    Pager<ExaminationEntity> pager(ExamQuery pager);

    List<AttaEntity> listFacdes(Long id);

    List<AttaEntity> listWound(Long id);

    void deleteAttas(Long examId, String ids);

    void uploadWound(Long examId, Atta atta, MultipartFile photo) throws IOException;

    void uploadFacade(Long examId, Atta atta, MultipartFile photo) throws IOException;
}
