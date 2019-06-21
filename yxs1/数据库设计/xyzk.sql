/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/8/20 10:41:03                           */
/*==============================================================*/


drop table if exists const;

drop table if exists dressing;

drop table if exists examine_result;

drop table if exists patient_info;

drop table if exists patient_wound;

drop table if exists wound_info;

drop table if exists wound_info_type;

drop table if exists wound_record;

drop table if exists wound_type;

/*==============================================================*/
/* Table: const                                                 */
/*==============================================================*/
create table const
(
   id                   int not null auto_increment,
   type                 varchar(50) comment '类型',
   value                varchar(200) comment '值',
   primary key (id)
);

alter table const comment '常量管理


（1）渗液颜色(penetration_color)：黄色、绿色、黄褐色
（2）渗透形状(penetration_shape)：粘稠、稀薄、其它（可输入）
（3）渗液量(penetration_quantity) ：干燥、湿润(＜5mL/24h)、潮湿 (5-10mL/24h)、饱和 (＞10mL/24h)、漏出 (＞10mL/24h)
（4）气味(smell)：无、移除敷料后可闻到、敷料存在时可闻到、与患者一个手臂距离可闻到、进入屋内可闻到、一进诊室就能闻到
（5）创面疼痛频率(pain_frequency) : 无、只在换药、间断疼痛、持续疼痛
（6）伤口边缘(wound_edge)：附着、非附着、卷边、上皮化
（7）周围皮肤状态(skin_condition)：正常、水泡、干燥、苍白...
（8）止疼药记录(painkillers)：肌肉注射、口服、局麻、表麻、特殊情况（可输入）
（9）伤口形态(wound_shape)：单个开放性伤口、多个临近开放性伤口、密集临近开放性伤口、单个开放性伤口的缝线伤口、多个开放性伤口的缝线伤口
（10）清创处理方式(debride_way)：保守锐器清创、自溶性清创、机械性清创、化学性清创、生物性清创、外科手术清创
（11）清洗液(debride_liquid) ：生理盐水、双氧水
（12）敷料种类(dressing_type)：泡沫类敷料、水胶体类、水凝胶类、液体敷料、藻酸盐敷料、薄膜类敷料。。。
（13）后续处理(after_process)：患者病例完整、带敷料回当地、本院继续处理
（14）全身性疾病（Systemic_disease）:神经系统疾病...';

/*==============================================================*/
/* Table: dressing                                              */
/*==============================================================*/
create table dressing
(
   id                   int not null auto_increment,
   name                 varchar(128) comment '名称',
   type_id              int comment '类型',
   company              varchar(128) comment '公司',
   specification        varchar(128) comment '规格',
   create_time          datetime comment '创建时间',
   primary key (id)
);

alter table dressing comment '敷料表';

/*==============================================================*/
/* Table: examine_result                                        */
/*==============================================================*/
create table examine_result
(
   id                   int not null auto_increment,
   patient_info_id      integer comment '患者信息表_Id',
   examine_time         datetime comment '检查时间',
   hgb                  varchar(128) comment '血红蛋白',
   hgb_time             datetime comment '血红蛋白记录时间',
   alb                  varchar(128) comment '血清白蛋白',
   alb_time             datetime comment '血清白蛋白记录时间',
   glu                  varchar(128) comment '血糖',
   glu_time             datetime comment '血糖记录时间',
   wsc                  varchar(128) comment '分泌物培养',
   wsc_time             datetime comment '分泌物培养记录时间',
   wbc                  varchar(128) comment '白细胞',
   wbc_time             datetime comment '白细胞记录时间',
   plt                  varchar(128) comment '血小板',
   plt_time             datetime comment '血小板记录时间',
   esr                  varchar(128) comment '血沉',
   esr_time             datetime comment '血沉记录时间',
   crp                  varchar(128) comment 'C反应蛋白',
   crp_time             datetime comment 'C反应蛋白记录时间',
   disease_result       varchar(128) comment '病理结果',
   primary key (id)
);

alter table examine_result comment '实验室检查结果';

/*==============================================================*/
/* Table: patient_info                                          */
/*==============================================================*/
create table patient_info
(
   id                   integer not null auto_increment,
   card_id              varchar(128) comment '患者卡号',
   ward                 varchar(128) comment '门诊/病室',
   name                 varchar(128) comment '姓名',
   sex                  tinyint comment '性别 1：男 ，2：女',
   age                  tinyint comment '年龄',
   diagnosis            varchar(128) comment '诊断',
   surgery              varchar(128) comment '手术',
   create_time          datetime comment '时间',
   primary key (id)
);

alter table patient_info comment '患者信息表';

/*==============================================================*/
/* Table: patient_wound                                         */
/*==============================================================*/
create table patient_wound
(
   id                   int not null auto_increment,
   patient_info_id      integer comment '患者_Id',
   wound_type_id        int comment '伤口类型',
   systemic_disease     int comment '全身性疾病信息，常量表',
   systemic_disease_detail varchar(128) comment '全身性疾病治疗情况与服用药物',
   create_time          datetime comment '创建时间',
   primary key (id)
);

alter table patient_wound comment '患者伤口表，一名患者可以记录多个伤口';

/*==============================================================*/
/* Table: wound_info                                            */
/*==============================================================*/
create table wound_info
(
   id                   int not null auto_increment,
   wound_record_id      int comment '伤口信息记录id',
   length               double comment '长度',
   width                double comment '宽度',
   depth                double comment '深度',
   volume               double comment '体积',
   area                 double comment '面积',
   suture_length        double comment '缝线长度',
   black                double comment '坏死（黑色）',
   yellow               double comment '腐肉（黄色）',
   red                  double comment '肉芽（红色）',
   pink                 double comment '上皮（粉红）',
   create_time          datetime comment '创建时间',
   primary key (id)
);

alter table wound_info comment '一次伤口记录中可以记录多个小伤口的信息';

/*==============================================================*/
/* Table: wound_info_type                                       */
/*==============================================================*/
create table wound_info_type
(
   id                   int not null auto_increment,
   wound_info_id        int comment '小伤口表id',
   type                 int comment '类型:  1、潜行，2、窦道，3、瘘管',
   length               double comment '长度',
   start_point          int comment '开始点',
   end_point            int comment '结束点',
   remark               varchar(255) comment '备注',
   primary key (id)
);

alter table wound_info_type comment '一个小伤口可以有多个潜行/窦道/瘘管
潜行：开始点、长度
窦道：开始点、结束点、长度
瘘管：开始点、备注、长度';

/*==============================================================*/
/* Table: wound_record                                          */
/*==============================================================*/
create table wound_record
(
   id                   int not null auto_increment,
   patient_wound_id     int comment '患者伤口表_id',
   create_time          datetime comment '记录时间',
   previous_exudate_pic varchar(128) comment '拍摄前一次渗液情况',
   before_debride_pic   varchar(128) comment '拍摄与测量清创前伤口',
   after_debride_pic    varchar(128) comment '拍摄与测量清创后伤口',
   site                 int comment '伤口部位，常量表',
   voice                varchar(128) comment '语音备注，保存到阿里云上',
   wound_shape          int comment '伤口形态，常量表',
   penetration_color    int comment '渗液颜色，常量表',
   penetration_shape    int comment '渗液形状，常量表',
   penetration_quantity int comment '渗液(量)，常量表',
   smell                int comment '气味，常量表',
   wound_edge           int comment '伤口边缘，常量表',
   pain_level           int comment '疼痛程度，常量表',
   pain_frequency       int comment '疼痛频率，常量表',
   painkillers          int comment '止疼药，疼痛程度大于4时需要设置止疼药，常量表',
   skin_condition       int comment '周围皮肤状态，常量表',
   debride_way          int comment '处理方式，常量表',
   debride_liquid       int comment '清洗液，常量表',
   after_dressing_pic   varchar(128) comment '敷药后伤口情形',
   dressing_package_pic varchar(128) comment '敷药包装图片',
   dressing_id          int comment '敷药表_id',
   after_process        int comment '后续处理，常量表',
   difficult_flag       tinyint comment '是否是疑难伤口 0：否，1：是',
   focus_flag           tinyint comment '是否重点关注:  0：否，1：是',
   complete_flag        tinyint comment '患者病历是否完整 0：否，1：是',
   nurse_name           varchar(128) comment '护士签名',
   primary key (id)
);

alter table wound_record comment '伤口信息记录';

/*==============================================================*/
/* Table: wound_type                                            */
/*==============================================================*/
create table wound_type
(
   id                   int not null auto_increment,
   name                 varchar(0) comment '伤口类型名称',
   parent_id            int comment '上一级id',
   create_time          datetime comment '创建时间',
   primary key (id)
);

alter table wound_type comment '伤口类型';

alter table examine_result add constraint FK_Reference_6 foreign key (patient_info_id)
      references patient_info (id) on delete restrict on update restrict;

alter table patient_wound add constraint FK_Reference_1 foreign key (patient_info_id)
      references patient_info (id) on delete restrict on update restrict;

alter table wound_info add constraint FK_Reference_4 foreign key (wound_record_id)
      references wound_record (id) on delete restrict on update restrict;

alter table wound_info_type add constraint FK_Reference_3 foreign key (wound_info_id)
      references wound_info (id) on delete restrict on update restrict;

alter table wound_record add constraint FK_Reference_2 foreign key (patient_wound_id)
      references patient_wound (id) on delete restrict on update restrict;

alter table wound_record add constraint FK_Reference_5 foreign key (dressing_id)
      references dressing (id) on delete restrict on update restrict;

