package dendy.rpms.controller;

import dendy.rpms.domain.PrimerEntity;
import dendy.rpms.entity.Genotype;
import dendy.rpms.entity.Primer;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.PrimerQuery;
import dendy.rpms.service.IGenotypeService;
import dendy.rpms.service.IPrimerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 引物信息
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/primer")
public class PrimerController {
    private static final Logger LOG = LoggerFactory.getLogger(PrimerController.class);
    @Autowired
    private IPrimerService primerService;
    @Autowired
    private IGenotypeService genotypeService;

    @RequestMapping(value = "/init", method = RequestMethod.POST)
    public String init() {
        return "/primer/primer";
    }

    @RequestMapping(value = "/toUpdatePage", method = RequestMethod.POST)
    public String toUpdatePage() {
        return "/primer/update";
    }

    @RequestMapping(value = "/toUpdateGenPage", method = RequestMethod.POST)
    public String toUpdateGenotypePage(Long genId, Model model) {
        Genotype genotype = genotypeService.get(genId);
        model.addAttribute("genotype", genotype);
        return "/primer/updateGenotype";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage() {
        return "/primer/add";
    }

    @RequestMapping(value = "/toAddGenPage", method = RequestMethod.POST)
    public String toAddGenotypePage(Long primerId, Model model) {
        Primer primer = primerService.get(primerId);
        model.addAttribute("primer", primer);
        return "/primer/addGenotype";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage update(Primer primer) {
        try {
            primerService.update(primer);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update house error :", e);
            return BaseMessage.errorMessage("修改失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(Primer primer) {
        try {
            primerService.add(primer);
            return BaseMessage.successMessage("添加成功！");
        } catch (Exception e) {
            LOG.error("add primer error : ", e);
            return BaseMessage.errorMessage("添加失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage delete(String ids) {
        try {
            primerService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete primers error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<PrimerEntity> pager(PrimerQuery primerQuery) {
        try {
            return primerService.page(primerQuery);
        } catch (Exception e) {
            LOG.error("Query primers has exception : ", e);
            return new Pager<>(0);
        }
    }

    @RequestMapping(value = "/sameGenNo", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameGenNo(String no, String primerNo) {
        try {
            Genotype genotype = genotypeService.getByNo(no, primerNo);
            if (genotype != null)
                return true;
            return false;
        } catch (Exception e) {
            LOG.error("check genotype same number has exception : ", e);
            return true;
        }
    }

    @RequestMapping(value = "/same", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameNo(String no) {
        try {
            Primer primer = primerService.getByNo(no);
            if (primer != null)
                return true;
            return false;
        } catch (Exception e) {
            LOG.error("check primer same number has exception : ", e);
            return true;
        }
    }
}
