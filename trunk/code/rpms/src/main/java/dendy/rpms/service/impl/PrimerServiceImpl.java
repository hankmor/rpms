package dendy.rpms.service.impl;

import dendy.rpms.dao.PrimerDao;
import dendy.rpms.domain.PrimerEntity;
import dendy.rpms.entity.Primer;
import dendy.rpms.entity.User;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.PrimerQuery;
import dendy.rpms.service.IPrimerService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
public class PrimerServiceImpl implements IPrimerService {
    @Autowired
    private PrimerDao dao;

    @Override
    public Primer get(Long id) {
        Assert.notNull(id);
        return dao.get(Primer.class, id);
    }

    @Override
    public Primer getByNo(String no) {
        Assert.hasLength(no);
        return dao.getByCode(no);
    }

    @Override
    @Transactional
    public void update(Primer primer) {
        Assert.notNull(primer);
        Primer src = dao.get(primer.getId());
        src.setNo(primer.getNo());
        src.setRemark(primer.getRemark());
        // 修改人
        User updateUser = UserUtil.getUserModel();
        src.setUserByUpdateUser(updateUser);
        src.setUpdateTime(new Date());
        dao.update(src);
    }

    @Override
    @Transactional
    public void add(Primer primer) {
        Assert.notNull(primer);

        User createUser = UserUtil.getUserModel();
        primer.setUserByCreateUser(createUser);
        primer.setCreateTime(new Date());
        dao.save(primer);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        List<Primer> primers = new LinkedList<>();
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Primer primer = dao.get(Primer.class, id);
            primers.add(primer);
        }
        dao.deleteAll(primers);
    }

    @Override
    public Pager<PrimerEntity> page(PrimerQuery primerQuery) {
        Assert.notNull(primerQuery, "primerQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(primerQuery.getPage(), primerQuery.getRows());
        return dao.findPagerData(primerQuery.projectionList(), primerQuery.getDomainClass(), primerQuery.getDetachedCriteria(), beginNum, primerQuery.getRows());
    }
}
