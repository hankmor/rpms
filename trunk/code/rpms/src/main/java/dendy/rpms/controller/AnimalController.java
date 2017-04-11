package dendy.rpms.controller;

import dendy.rpms.domain.AnimalEntity;
import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.Atta;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.AnimalQuery;
import dendy.rpms.service.IAnimalService;
import dendy.rpms.service.IAnimalTypeService;
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
 * 动物控制器
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/rp")
public class AnimalController {
    private static final Logger LOG = LoggerFactory.getLogger(AnimalController.class);
    @Autowired
    private IAnimalService animalService;
    @Autowired
    private IAnimalTypeService animalTypeService;

    @RequestMapping(value = "init", method = RequestMethod.POST)
    public String init() {
        return "/animal/animal";
    }

    @RequestMapping(value = "/toUpdatePage", method = RequestMethod.POST)
    public String toUpdatePage(Model model) {
        List<AnimalTypeEntity> animalTypes = animalTypeService.list();
        model.addAttribute("animalTypes", animalTypes);
        return "/animal/update";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage(Model model) {
        List<AnimalTypeEntity> animalTypes = animalTypeService.list();
        model.addAttribute("animalTypes", animalTypes);
        return "/animal/add";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage update(Animal animal) {
        try {
            animalService.update(animal);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update house error :", e);
            return BaseMessage.errorMessage("修改失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(Animal animal) {
        try {
            animalService.add(animal);
            return BaseMessage.successMessage("添加成功！");
        } catch (Exception e) {
            LOG.error("add house error : ", e);
            return BaseMessage.errorMessage("添加失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage delete(String ids) {
        try {
            animalService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete house error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    /**
     * 查询小熊猫信息
     *
     * @param animalQuery 查询表单
     * @return 分页对象
     */
    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<AnimalEntity> pager(AnimalQuery animalQuery) {
        try {
            return animalService.page(animalQuery);
        } catch (Exception e) {
            LOG.error("Query houses has exception : ", e);
            return new Pager<>(0);
        }
    }

    /**
     * 检查编号是否重复
     *
     * @param no
     * @return
     */
    @RequestMapping(value = "/sameNo", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameNo(String no) {
        try {
            Animal animal = animalService.getByNo(no);
            if (animal != null)
                return true;
            else return false;
        } catch (Exception e) {
            LOG.error("Query houses has exception : ", e);
            return true;
        }
    }

    /**
     * 检查芯片号是否重复
     *
     * @param no
     * @return
     */
    @RequestMapping(value = "/sameChipNo", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameChipNo(String no) {
        try {
            Animal animal = animalService.getByMicrochipCode(no);
            if (animal != null)
                return true;
            else return false;
        } catch (Exception e) {
            LOG.error("Query houses has exception : ", e);
            return true;
        }
    }

    /**
     * 调整到标记页面
     *
     * @return
     */
    @RequestMapping("toMarkPage")
    public String toMarkPage() {
        return "/animal/mark";
    }

    /**
     * 标记动物为死亡.
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/mark", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage mark(String ids, Animal animal) {
        try {
            animalService.mark(ids, animal);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("mark animals failed : ", e);
            return BaseMessage.errorMessage("操作失败，系统出现未知错误.");
        }
    }

    // ~ 基因型管理 =====================================================================================================

    @RequestMapping("/toAddGenPage")
    public String toAddGenPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        return "/ag/add";
    }

    @RequestMapping(value = "/addGens", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage addGenotypes(Long id, String primerNo, String codeA, String codeB) {
        try {
            animalService.addGenotypes(id, primerNo, codeA, codeB);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("mark animals failed : ", e);
            return BaseMessage.errorMessage("操作失败，系统出现未知错误.");
        }
    }

    @RequestMapping(value = "/deleteGens", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage deleteGenotypes(Long id, String ids) {
        try {
            animalService.deleteGenotypes(id, ids);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("mark animals failed : ", e);
            return BaseMessage.errorMessage("操作失败，系统出现未知错误.");
        }
    }

    @RequestMapping("/toPhotoPage")
    public String toPhotoPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        List<AttaEntity> attaEntities = animalService.listAttas(animalId);
        model.addAttribute("attas", attaEntities);
        return "/animal/photo";
    }

    // ~ 照片管理 =======================================================================================================

    @RequestMapping("/toShowPhotoPage")
    public String toPhotoShowPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        List<AttaEntity> attaEntities = animalService.listAttas(animalId);
        model.addAttribute("attas", attaEntities);
        return "/animal/showPhoto";
    }

    @RequestMapping("/toPhotoUploadPage")
    public String toPhotoUploadPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        return "/animal/photo-upload";
    }

    @RequestMapping(value = "/uploadPhoto", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage uploadPhoto(Long animalId, Atta atta, MultipartFile photo) {
        try {
            animalService.uploadPhoto(animalId, atta, photo);
            return BaseMessage.successMessage("上传成功！");
        } catch (Exception e) {
            LOG.error("upload photo failed : ", e);
            return BaseMessage.errorMessage("上传失败，系统出现未知错误.");
        }
    }

    @RequestMapping(value = "/deletePhoto", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage deletePhoto(Long animalId, String ids) {
        try {
            animalService.deletePhotos(animalId, ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete photo failed : ", e);
            return BaseMessage.errorMessage("删除失败，系统出现未知错误.");
        }
    }

    // ~ 体检信息管理 ===================================================================================================

    @RequestMapping("/toExamPage")
    public String toExamPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        return "/ae/ae";
    }

    // ~ 谱系图 =========================================================================================================

    @RequestMapping("/px")
    public String toStudBookShowPage(Long animalId, Model model) {
        Animal animal = animalService.get(animalId);
        model.addAttribute("animal", animal);
        return "/as/show";
    }
}
