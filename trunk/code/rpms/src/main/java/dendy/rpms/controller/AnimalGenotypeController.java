package dendy.rpms.controller;

import dendy.rpms.domain.AnimalGenotypeEntity;
import dendy.rpms.domain.AnimalGenotypeItemEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.AnimalGenotype;
import dendy.rpms.entity.Genotype;
import dendy.rpms.entity.Primer;
import dendy.rpms.page.Pager;
import dendy.rpms.query.AnimalGenotypeQuery;
import dendy.rpms.service.IAnimalGenotypeSerice;
import dendy.rpms.service.IAnimalService;
import dendy.rpms.service.IPrimerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 动物基因型控制器
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/ag")
public class AnimalGenotypeController {
    private static final Logger LOG = LoggerFactory.getLogger(AnimalGenotypeController.class);
    @Autowired
    private IAnimalService animalService;
    @Autowired
    private IPrimerService primerService;
    @Autowired
    private IAnimalGenotypeSerice animalGenotypeSerice;

    @RequestMapping(value = "init", method = RequestMethod.POST)
    public String init() {
        return "/ag/ag";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage(Model model) {
        return "/ag/add";
    }

/*    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(Long id, String ids) {
        try {
            animalService.addGenotypes(id, primerId, codeA, ids);
            return BaseMessage.successMessage("添加成功！");
        } catch (Exception e) {
            LOG.error("add genotypes error : ", e);
            return BaseMessage.errorMessage("添加失败，请稍后重试!");
        }
    }*/

/*    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage delete(Long id, String ids) {
        try {
            animalService.deleteGenotypes(id, ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete genotypes error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }*/

    /**
     * 跳转到基因型对比页面
     *
     * @param ids   需要对比基因型的动物
     * @param model
     * @return
     */
    @RequestMapping("/cp/init")
    public String compare(String ids, Model model) {
        model.addAttribute("animalIds", ids);
        return "/ag/compare";
    }

    /**
     * 获取对比的动物和其基因型数据
     *
     * @param animalIds
     * @return
     */
    @RequestMapping("/cp/data")
    @ResponseBody
    public List<AnimalGenotypeEntity> getData(String animalIds, String primerIds) {
        List<AnimalGenotypeEntity> ages = new LinkedList<>();
        if (StringUtils.hasLength(animalIds)) {
            String[] idArray = animalIds.split(",");
            // 所有引物列表
            List<Primer> primers = getPrimers(animalIds, primerIds);
            for (String s : idArray) {
                long id = Long.valueOf(s);
                Animal animal = animalService.getWithGenotypes(id);
                AnimalGenotypeEntity age = new AnimalGenotypeEntity();
                age.setId(animal.getId());
                age.setMicrochipCode(animal.getMicrochipCode());
                age.setName(animal.getName());
                age.setTatooCode(animal.getTatooCode());
                // 按照给定的引物编号顺序，依次获取动物的对应基因型
                Set<AnimalGenotype> animalGenotypes = animal.getAnimalGenotypes();
                Map<String, AnimalGenotypeEntity.GenotypeInfo> genotypeInfoMap = new LinkedHashMap<>();
                for (Primer primer : primers) {
                    String no = primer.getNo();
                    boolean find = false;
                    for (AnimalGenotype ag : animalGenotypes) {
                        Primer p = ag.getPrimer();
                        // 找到引物对应的动物的基因型
                        if (no.equalsIgnoreCase(p.getNo())) {
                            AnimalGenotypeEntity.GenotypeInfo genotypeInfo = new AnimalGenotypeEntity().new GenotypeInfo();
                            Genotype aga = ag.getGenotypeByGenotypeA();
                            Genotype agb = ag.getGenotypeByGenotypeB();
                            if (aga != null)
                                genotypeInfo.setCodeA(aga.getCodeA());
                            else genotypeInfo.setCodeA(null);
                            if (agb != null)
                                genotypeInfo.setCodeB(agb.getCodeA());
                            else genotypeInfo.setCodeB(null);
                            genotypeInfoMap.put(no, genotypeInfo);
                            find = true;
                            break;
                        }
                    }
                    if (!find) {
                        AnimalGenotypeEntity.GenotypeInfo genotypeInfo = new AnimalGenotypeEntity().new GenotypeInfo();
                        genotypeInfo.setCodeA(null);
                        genotypeInfo.setCodeB(null);
                        genotypeInfoMap.put(no, genotypeInfo);
                    }
                }
                age.setGenotypeInfos(genotypeInfoMap);
                ages.add(age);
            }
        }
        return ages;
    }

    /**
     * 获取引物列表
     *
     * @param animalIds
     * @param primerIds
     * @return
     */
    @RequestMapping("/cp/primers")
    @ResponseBody
    public List<Primer> getPrimers(String animalIds, String primerIds) {
        List<Primer> primers = new LinkedList<>();
        // 有引物ids，优先处理
        if (StringUtils.hasLength(primerIds)) {
            if (StringUtils.hasLength(primerIds)) {
                String[] idsArray = primerIds.split(",");
                for (String s : idsArray) {
                    Long id = Long.valueOf(s);
                    primers.add(primerService.get(id));
                }
            }
        } else if (StringUtils.hasLength(animalIds)) {
            Set<Primer> primerSet = new LinkedHashSet<>();
            String[] idArray = animalIds.split(",");
            // 获取动物的所有引物集合
            for (String s : idArray) {
                long id = Long.valueOf(s);
                Animal animal = animalService.getWithGenotypes(id);
                Set<AnimalGenotype> ags = animal.getAnimalGenotypes();
                // 去重
                for (AnimalGenotype ag : ags) {
                    Primer primer = primerService.get(ag.getPrimer().getId());
                    primerSet.add(primer);
                }
            }
            primers.addAll(primerSet);
        }
        Collections.sort(primers, new Comparator<Primer>() {
            @Override
            public int compare(Primer o1, Primer o2) {
                if (o1.getId() > o2.getId())
                    return 1;
                else if (o1.getId() < o2.getId())
                    return -1;
                else return 0;
            }
        });
        return primers;
    }

    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<AnimalGenotypeItemEntity> pager(AnimalGenotypeQuery animalGenotypeQuery) {
        try {
            return animalGenotypeSerice.page(animalGenotypeQuery);
        } catch (Exception e) {
            LOG.error("Query animal genotypes has exception : ", e);
            return new Pager<>(0);
        }
    }
}
