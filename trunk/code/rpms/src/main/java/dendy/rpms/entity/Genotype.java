package dendy.rpms.entity;

// Generated 2014-10-26 13:48:43 by Hibernate Tools 3.6.0

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Genotype generated by hbm2java
 */
@Entity
@Table(name = "genotype", catalog = "rpms")
public class Genotype implements java.io.Serializable {

	private Long				id;
	private User				userByUpdateUser;
	private Primer				primer;
	private User				userByCreateUser;
	private Integer				codeA;
	private Integer				codeB;
	private Date				createTime;
	private Date				updateTime;
	private String				remark;
	private Set<AnimalGenotype>	animalGenotypesForGenotypeB	= new HashSet<AnimalGenotype>(0);
	private Set<AnimalGenotype>	animalGenotypesForGenotypeA	= new HashSet<AnimalGenotype>(0);

	public Genotype() {
	}

	public Genotype(Primer primer) {
		this.primer = primer;
	}

	public Genotype(User userByUpdateUser, Primer primer, User userByCreateUser, Integer codeA, Integer codeB, Date createTime,
			Date updateTime, String remark, Set<AnimalGenotype> animalGenotypesForGenotypeB, Set<AnimalGenotype> animalGenotypesForGenotypeA) {
		this.userByUpdateUser = userByUpdateUser;
		this.primer = primer;
		this.userByCreateUser = userByCreateUser;
		this.codeA = codeA;
		this.codeB = codeB;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.remark = remark;
		this.animalGenotypesForGenotypeB = animalGenotypesForGenotypeB;
		this.animalGenotypesForGenotypeA = animalGenotypesForGenotypeA;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UPDATE_USER")
	public User getUserByUpdateUser() {
		return this.userByUpdateUser;
	}

	public void setUserByUpdateUser(User userByUpdateUser) {
		this.userByUpdateUser = userByUpdateUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PRIMER", nullable = false)
	public Primer getPrimer() {
		return this.primer;
	}

	public void setPrimer(Primer primer) {
		this.primer = primer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATE_USER")
	public User getUserByCreateUser() {
		return this.userByCreateUser;
	}

	public void setUserByCreateUser(User userByCreateUser) {
		this.userByCreateUser = userByCreateUser;
	}

	@Column(name = "CODE_A")
	public Integer getCodeA() {
		return this.codeA;
	}

	public void setCodeA(Integer codeA) {
		this.codeA = codeA;
	}

	@Column(name = "CODE_B")
	public Integer getCodeB() {
		return this.codeB;
	}

	public void setCodeB(Integer codeB) {
		this.codeB = codeB;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATE_TIME", length = 19)
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPDATE_TIME", length = 19)
	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "REMARK", length = 300)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "genotypeByGenotypeB")
	public Set<AnimalGenotype> getAnimalGenotypesForGenotypeB() {
		return this.animalGenotypesForGenotypeB;
	}

	public void setAnimalGenotypesForGenotypeB(Set<AnimalGenotype> animalGenotypesForGenotypeB) {
		this.animalGenotypesForGenotypeB = animalGenotypesForGenotypeB;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "genotypeByGenotypeA")
	public Set<AnimalGenotype> getAnimalGenotypesForGenotypeA() {
		return this.animalGenotypesForGenotypeA;
	}

	public void setAnimalGenotypesForGenotypeA(Set<AnimalGenotype> animalGenotypesForGenotypeA) {
		this.animalGenotypesForGenotypeA = animalGenotypesForGenotypeA;
	}

}
