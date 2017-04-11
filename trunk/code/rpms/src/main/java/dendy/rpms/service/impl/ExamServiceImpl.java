package dendy.rpms.service.impl;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.dao.AnimalDao;
import dendy.rpms.dao.ExamDao;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.domain.ExaminationEntity;
import dendy.rpms.entity.*;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.ExamQuery;
import dendy.rpms.service.IAttaService;
import dendy.rpms.service.IExamService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.FileHelper;
import dendy.rpms.utils.FileNameHelper;
import dendy.rpms.utils.UserUtil;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/9/13.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Service
public class ExamServiceImpl implements IExamService {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(ExamServiceImpl.class);

    private static final String EXAM_FILE_SAVE_FOLDER = "exam-photos";

    //~ Instance fields ================================================================================================
    @Autowired
    private ExamDao examDao;
    @Autowired
    private AnimalDao animalDao;
    @Autowired
    private IAttaService attaService;

    //~ Methods ========================================================================================================

    @Override
    public Examination get(Long id) {
        Assert.notNull(id);
        return examDao.get(id);
    }

    @Override
    @Transactional
    public void add(Examination examination) {
        Assert.notNull(examination);
        User createUser = UserUtil.getUserModel();
        examination.setUserByCreateUser(createUser);
        examination.setCreateTime(new Date());
        examDao.save(examination);
    }

    @Override
    @Transactional
    public void update(Examination examination) {
        Assert.notNull(examination);
        User updateUser = UserUtil.getUserModel();
        examination.setUserByUpdateUser(updateUser);
        examination.setUpdateTime(new Date());
        examDao.update(examination);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        LOG.info("delete examinations with id in " + ids);
        String[] idArray = ids.split(",");
        List<Examination> examinations = new LinkedList<>();
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Examination examination = get(id);
            examinations.add(examination);
        }
        examDao.deleteAll(examinations);
    }

    @Override
    public Pager<ExaminationEntity> pager(ExamQuery examQuery) {
        Assert.notNull(examQuery, "ExamQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(examQuery.getPage(), examQuery.getRows());
        return examDao.findPagerData(examQuery.projectionList(), examQuery.getDomainClass(),
                examQuery.getDetachedCriteria(), beginNum, examQuery.getRows());
    }

    @Override
    public List<AttaEntity> listFacdes(Long id) {
        Assert.notNull(id);
        return examDao.listAttas(id, SystemConst.EXAM_ATTA_TYPE_FACADE);
    }

    @Override
    public List<AttaEntity> listWound(Long id) {
        Assert.notNull(id);
        return examDao.listAttas(id, SystemConst.EXAM_ATTA_TYPE_WOUND);
    }

    @Override
    public void deleteAttas(Long examId, String ids) {
        Assert.notNull(examId);
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");

        File[] files = new File[idArray.length];
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Atta atta = attaService.get(id);
            String savedPath = SystemConst.FILE_SAVE_PATH + atta.getPath() + atta.getFileName();
            files[i] = new File(savedPath);
        }
        // 数据库会级联删除ExaminationAtta中的记录
        attaService.delete(ids);
        FileHelper.deleteFiles(files);
    }

    @Override
    @Transactional
    public void uploadWound(Long examId, Atta atta, MultipartFile photo) throws IOException {
        uploadAtta(examId, atta, photo, SystemConst.EXAM_ATTA_TYPE_WOUND);
    }

    @Override
    @Transactional
    public void uploadFacade(Long examId, Atta atta, MultipartFile photo) throws IOException {
        uploadAtta(examId, atta, photo, SystemConst.EXAM_ATTA_TYPE_FACADE);
    }

    private void uploadAtta(Long examId, Atta atta, MultipartFile photo, byte type) throws IOException {
        Assert.notNull(examId);
        Assert.notNull(atta);
        Assert.notNull(photo);
        Examination examination = get(examId);
        String relativeSavePath = "/" + EXAM_FILE_SAVE_FOLDER + "/" + examination.getAnimal().getId() + "/" + examId + "/facade/";
        if (type == SystemConst.EXAM_ATTA_TYPE_WOUND)
            relativeSavePath = "/" + EXAM_FILE_SAVE_FOLDER + "/" + examination.getAnimal().getId() + "/" + examId + "/wound/";

        String realSavePath = SystemConst.FILE_SAVE_PATH + relativeSavePath;

        File savePath = new File(realSavePath);
        if (!savePath.exists() || !savePath.isDirectory()) savePath.mkdirs();

        String srcFileName = photo.getOriginalFilename();
        InputStream is = photo.getInputStream();
        String ext = FileNameHelper.getExtension(srcFileName);
        String savedFileName = FileNameHelper.timestampFileName(ext);

        Atta dest = new Atta();
        dest.setName(StringUtils.hasLength(atta.getName()) ? atta.getName() + "." + ext : srcFileName);
        dest.setFileName(savedFileName);
        dest.setDescription(atta.getDescription());
        dest.setRemark(atta.getRemark());
        dest.setSize((long) is.available());
        dest.setPath(relativeSavePath);
        dest.setType(SystemConst.ATTA_TYPE_PIC);

        User createUser = UserUtil.getUserModel();
        dest.setUserByUploadUser(createUser);
        dest.setUploadTime(new Date());

        FileUtils.copyInputStreamToFile(is, new File(realSavePath + savedFileName));

        attaService.add(dest);

//        Examination exam = examDao.getWithAttas(examId);
//        Set<ExaminationAtta> eas = exam.getExaminationAttas();

        ExaminationAttaId examinationAttaId = new ExaminationAttaId();
        examinationAttaId.setAtta(dest.getId());
        examinationAttaId.setExamination(examination.getId());

        ExaminationAtta ea = new ExaminationAtta();
        ea.setId(examinationAttaId);
        ea.setAtta(dest);
        ea.setExamination(examination);
        ea.setType(type);
//        eas.add(ea);

        // 无效，不能级联插入记录？
//        examDao.update(exam);
        examDao.save(ea);
    }
}