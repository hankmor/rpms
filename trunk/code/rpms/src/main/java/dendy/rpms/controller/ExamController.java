package dendy.rpms.controller;

import dendy.rpms.domain.AttaEntity;
import dendy.rpms.domain.ExaminationEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.Atta;
import dendy.rpms.entity.Examination;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.ExamQuery;
import dendy.rpms.service.IAnimalService;
import dendy.rpms.service.IExamService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>Created by Dendy on 2014/9/13.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@RequestMapping("/exam")
@Controller
public class ExamController {
    //~ Static fields/initializers =====================================================================================

    private static final Logger LOG = LoggerFactory.getLogger(ExamController.class);

    //~ Instance fields ================================================================================================

    @Autowired
    private IExamService examService;
    @Autowired
    private IAnimalService animalService;

    //~ Methods ========================================================================================================

    /**
     * @param id    动物id
     * @param model
     * @return
     */
    @RequestMapping("/toAddPage")
    public String toAddPage(Long id, Model model) {
        Animal animal = animalService.get(id);
        model.addAttribute("animal", animal);
        return "/ae/add";
    }

    /**
     * @param id    动物id
     * @param model
     * @return
     */
    @RequestMapping("/toUpdatePage")
    public String toUpdatePage(Long id, Model model) {
        Animal animal = animalService.get(id);
        model.addAttribute("animal", animal);
        return "/ae/update";
    }

    @RequestMapping("/pager")
    @ResponseBody
    public Pager<ExaminationEntity> pager(ExamQuery examPager) {
        try {
            return examService.pager(examPager);
        } catch (Exception e) {
            LOG.error("Query examinations has exception : ", e);
            return new Pager<>(0);
        }
    }

    @RequestMapping("/add")
    @ResponseBody
    public BaseMessage add(Examination examination) {
        try {
            examService.add(examination);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("add examination has exception : ", e);
            return BaseMessage.errorMessage("操作失败，系统出现未知错误！");
        }
    }

    @RequestMapping("/update")
    @ResponseBody
    public BaseMessage update(Examination examination) {
        try {
            examService.update(examination);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("update examination has exception : ", e);
            return BaseMessage.errorMessage("操作失败，系统出现未知错误！");
        }
    }

    @RequestMapping("/delete")
    @ResponseBody
    public BaseMessage delete(String ids) {
        try {
            examService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete exams error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    // ~ 外观特征 =======================================================================================================

    /**
     * @param id    体检记录id
     * @param model
     * @return
     */
    @RequestMapping("/toFacadePage")
    public String toFacadePage(Long id, Model model) {
        Examination examination = examService.get(id);
        List<AttaEntity> attaEntities = examService.listFacdes(id);
        model.addAttribute("exam", examination);
        model.addAttribute("facades", attaEntities);
        return "/ae/facade";
    }

    @RequestMapping("/toFacadeUploadPage")
    public String toFacadeUploadPage(Long id, Model model) {
        Examination examination = examService.get(id);
        model.addAttribute("exam", examination);
        return "/ae/facade-upload";
    }

    @RequestMapping(value = "/deleteFacade", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage deleteFacade(Long examId, String ids) {
        try {
            examService.deleteAttas(examId, ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete photo failed : ", e);
            return BaseMessage.errorMessage("删除失败，系统出现未知错误.");
        }
    }

    @RequestMapping(value = "/uploadFacade", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage uploadFacade(Long examId, Atta atta, MultipartFile photo) {
        try {
            examService.uploadFacade(examId, atta, photo);
            return BaseMessage.successMessage("上传成功！");
        } catch (Exception e) {
            LOG.error("upload facade failed : ", e);
            return BaseMessage.errorMessage("上传失败，系统出现未知错误.");
        }
    }

    @RequestMapping("/toShowFacadePage")
    public String toShowFacadePage(Long examId, Model model) {
        List<AttaEntity> attaEntities = examService.listFacdes(examId);
        model.addAttribute("attas", attaEntities);
        return "/ae/showPhoto";
    }

    // ~ 受伤情况 =======================================================================================================

    /**
     * @param id    体检记录id
     * @param model
     * @return
     */
    @RequestMapping("/toWoundPage")
    public String toWoundPage(Long id, Model model) {
        Examination examination = examService.get(id);
        model.addAttribute("exam", examination);
        List<AttaEntity> attaEntities = examService.listWound(id);
        model.addAttribute("wounds", attaEntities);
        return "/ae/wound";
    }

    @RequestMapping("/toWoundUploadPage")
    public String toWoundUploadPage(Long id, Model model) {
        Examination examination = examService.get(id);
        model.addAttribute("exam", examination);
        return "/ae/wound-upload";
    }

    @RequestMapping(value = "/deleteWound", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage deleteWound(Long examId, String ids) {
        try {
            examService.deleteAttas(examId, ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete photo failed : ", e);
            return BaseMessage.errorMessage("删除失败，系统出现未知错误.");
        }
    }

    @RequestMapping(value = "/uploadWound", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage uploadWound(Long examId, Atta atta, MultipartFile photo) {
        try {
            examService.uploadWound(examId, atta, photo);
            return BaseMessage.successMessage("上传成功！");
        } catch (Exception e) {
            LOG.error("upload wound failed : ", e);
            return BaseMessage.errorMessage("上传失败，系统出现未知错误.");
        }
    }

    @RequestMapping("/toShowWoundPage")
    public String toShowWoundPage(Long examId, Model model) {
        List<AttaEntity> attaEntities = examService.listWound(examId);
        model.addAttribute("attas", attaEntities);
        return "/ae/showPhoto";
    }
}
