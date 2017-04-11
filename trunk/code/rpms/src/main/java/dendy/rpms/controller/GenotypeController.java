package dendy.rpms.controller;

import dendy.rpms.domain.GenotypeEntity;
import dendy.rpms.entity.Genotype;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.GenotypeQuery;
import dendy.rpms.service.IGenotypeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 引物信息
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/gen")
public class GenotypeController {
    private static final Logger LOG = LoggerFactory.getLogger(GenotypeController.class);
    @Autowired
    private IGenotypeService genotypeService;

    @RequestMapping(value = "/init", method = RequestMethod.POST)
    public String init() {
        return "/genotype/genotype";
    }

    @RequestMapping(value = "/toUpdatePage", method = RequestMethod.POST)
    public String toUpdatePage() {
        return "/genotype/update";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage() {
        return "/genotype/add";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage update(Genotype genotype) {
        try {
            genotypeService.update(genotype);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update house error :", e);
            return BaseMessage.errorMessage("修改失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(Genotype genotype) {
        try {
            genotypeService.add(genotype);
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
            genotypeService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete primers error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<GenotypeEntity> pager(GenotypeQuery genotypeQuery) {
        try {
            return genotypeService.page(genotypeQuery);
        } catch (Exception e) {
            LOG.error("Query primers has exception : ", e);
            return new Pager<>(0);
        }
    }

    /**
     * 查询所有code
     *
     * @param primerNo 引物编号
     * @param code     搜索条件code，like查询
     * @return
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public List<GenotypeEntity> listAll(String primerNo, String code) {
        try {
            return genotypeService.listAll(primerNo, code);
        } catch (Exception e) {
            LOG.error("Query primers has exception : ", e);
            return new ArrayList<>(0);
        }
    }
}
