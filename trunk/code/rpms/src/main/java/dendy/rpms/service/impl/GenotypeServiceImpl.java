package dendy.rpms.service.impl;

import dendy.rpms.dao.GenotypeDao;
import dendy.rpms.domain.GenotypeEntity;
import dendy.rpms.entity.Genotype;
import dendy.rpms.entity.User;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.GenotypeQuery;
import dendy.rpms.service.IGenotypeService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * 引物服务实现
 *
 * @author Dendy
 * @since 14-2-21
 */
@Service
public class GenotypeServiceImpl implements IGenotypeService {
    @Autowired
    private GenotypeDao dao;

    @Override
    public Genotype get(Long id) {
        Assert.notNull(id);
        return dao.get(Genotype.class, id);
    }

    @Override
    @Transactional
    public void update(Genotype genotype) {
        Assert.notNull(genotype);
        Genotype src = dao.get(genotype.getId());
        src.setCodeA(genotype.getCodeA());
        src.setCodeB(genotype.getCodeB());
        src.setRemark(genotype.getRemark());
        // 修改人
        User updateUser = UserUtil.getUserModel();
        src.setUserByUpdateUser(updateUser);
        src.setUpdateTime(new Date());
        dao.update(src);
    }

    @Override
    @Transactional
    public void add(Genotype genotype) {
        Assert.notNull(genotype);
        User createUser = UserUtil.getUserModel();
        genotype.setUserByCreateUser(createUser);
        genotype.setCreateTime(new Date());
        dao.save(genotype);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        List<Genotype> genotypes = new LinkedList<>();
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Genotype genotype = dao.get(Genotype.class, id);
            genotypes.add(genotype);
        }
        dao.deleteAll(genotypes);
    }

    @Override
    public Pager<GenotypeEntity> page(GenotypeQuery genotypeQuery) {
        Assert.notNull(genotypeQuery, "genotypeQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(genotypeQuery.getPage(), genotypeQuery.getRows());
        return dao.findPagerData(genotypeQuery.projectionList(), genotypeQuery.getDomainClass(), genotypeQuery.getDetachedCriteria(), beginNum, genotypeQuery.getRows());
    }

    @Override
    public Genotype getByNo(String no, String primerNo) {
        Assert.hasLength(no);
        return dao.getByNo(no, primerNo);
    }

    @Override
    public List<GenotypeEntity> listAll(String primerNo, String code) {
        if (StringUtils.hasLength(primerNo))
            return dao.listByCondition(primerNo, code);
        return new ArrayList<>();
    }
}
