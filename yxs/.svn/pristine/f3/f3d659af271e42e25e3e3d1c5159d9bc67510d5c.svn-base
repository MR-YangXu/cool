<template>
  <div id="sickMessage" v-loading="loading">
    <div style="position: fixed;top: 0;width: 100%;z-index: 3;background-color: #fff;">
      <h1><span @click="linkTo"></span><icon style="padding-left:10px;" class="left" name="back" width="30" height="30"></icon><span class="center">患者:{{sickData.name}}</span></h1>
      <el-row class="tabBorder">
        <el-col :span="12"><div @click="Switch" :class="{tabActive:active}" class="tabList">患者基本个人信息与病史记录</div></el-col>
        <el-col :span="12"><div @click="Switch" :class="{tabActive:!active}" class="tabList">患者伤口信息历史</div></el-col>
      </el-row>
    </div>
    <div class="tab">
      <div class="tabShow" v-show="active">
        <h6>个人基本信息</h6>
        <el-form label-width="100px">
          <el-row>
            <el-col :span="11">
              <el-form-item label="科室/病室：">
                <el-input v-model="sickData.ward" @focus="hideFoot" @blur="showFoot"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="11">
              <el-form-item label="床号：">
                <el-input v-model="sickData.bedNo" @focus="hideFoot" @blur="showFoot"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="11">
              <el-form-item label="姓名：">
                <el-input v-model="sickData.name" @focus="hideFoot" @blur="showFoot"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="11">
              <el-form-item label="ID号：">
                <el-input v-model="sickData.cardId" @focus="hideFoot" @blur="showFoot"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
             <el-col :span="11">
              <el-form-item label="性别：">
                <el-select v-model="sickData.sex" placeholder="请选择">
                  <el-option label="男" :value="1"></el-option>
                  <el-option label="女" :value="2"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="11">
              <el-form-item label="年龄：" >
                <el-input @focus="hideFoot" @blur="showFoot" type="number" v-model="sickData.age"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="22">
              <el-form-item label="诊断：">
                <el-input @focus="hideFoot" @blur="showFoot" v-model="sickData.diagnosis"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="11">
              <el-form-item label="手术：">
                <el-input @focus="hideFoot" @blur="showFoot" v-model="sickData.surgery"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="11">
              <el-form-item label="时间：">
                <el-date-picker
                  v-model="sickData.examineTime"
                  value-format="yyyy/MM/dd"
                  type="date"
                  placeholder="选择日期"
                  @focus="hideFoot"
                  @blur="showFoot">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
        <h6>全身性疾病信息</h6>
        <el-input class="paddingLR30" v-model="sickData.systemicDisease" @focus="hideFoot" @blur="showFoot"></el-input>
        <h6>全身性疾病治疗情况与服用药物 <span v-if="sickData.systemicDetailTime" class="updateTime">·[{{sickData.systemicDetailTime}}更新]</span></h6>
        <el-input class="paddingLR30" v-model="sickData.systemicDetail" @focus="hideFoot" @blur="showFoot"></el-input>
        <h6>实验室检查结果 <span v-if="sickData.createTime" class="updateTime">·[{{sickData.createTime}}更新]</span></h6>
        <div class="paddingLR30 paddingBottom50">
          <table border="1" cellspacing="0" cellpadding="0">
            <tr class="trStyle trHeight">
              <th class="thWeight">&nbsp;</th>
              <th class="thWeight">血红蛋白<br><span>130~175g/L</span></th>
              <th class="thWeight">血清白蛋白<br><span>40.0~55.0g/L</span></th>
              <th class="thWeight">血糖<br><span>3.9~6.1mmol/L</span></th>
              <th class="thWeight">分泌物培养</th>
            </tr>
            <tr class="trHeight">
              <th class="thWeight">日期</th>
              <td><el-input @focus="hideFoot" @blur="showFoot"  class="tableInput" v-model="sickData.hgbTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.albTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.gluTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.wscTime"></el-input></td>
            </tr>
            <tr class="trHeight">
              <th class="thWeight">结果</th>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.hgb"></el-input></td>
              <td><el-input @focus="hideFoot" @blur="showFoot"  class="tableInput" v-model="sickData.alb"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.glu"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.wsc"></el-input></td>
            </tr>
          </table>
          <table border="1" cellspacing="0" cellpadding="0">
            <tr class="trStyle trHeight">
              <th class="thWeight">&nbsp;</th>
              <th class="thWeight">白细胞<br><span>(3.5~9.5)*10g/L</span></th>
              <th class="thWeight">血小板<br><span>(125-350)*10g/L</span></th>
              <th class="thWeight">血沉<br><span>0-43mm/h</span></th>
              <th class="thWeight">C反应蛋白<br><span>0~8.0mg/L</span></th>
            </tr>
            <tr class="trHeight">
              <th class="thWeight">日期</th>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.wbcTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.pltTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.esrTime"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.crpTime"></el-input></td>
            </tr>
            <tr class="trHeight">
              <th class="thWeight">结果</th>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.wbc"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.plt"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.esr"></el-input></td>
              <td><el-input  @focus="hideFoot" @blur="showFoot" class="tableInput" v-model="sickData.crp"></el-input></td>
            </tr>
          </table>
          <div class="jieguo">
            <span style="diaplay:inline-block;line-height:40px;width:80px;">病理结果:</span>
            <el-input @focus="hideFoot" @blur="showFoot" v-model="sickData.diseaseResult"></el-input>
          </div>
        </div>
      </div>
      <div class="tabShow paddingLR20" v-show="!active">
        <template >
          <div class="woundNum" v-if="woundInfoHistory.length >= 2">
            <el-button class="buttonBGC" @click="chooseBigWound(index)"  v-for="(item,index)  in woundInfoHistory" :key="index" size="mini" >{{item.woundName}}</el-button>
          </div>
          <div v-if="woundInfoHistory.length > 0&&woundInfoHistory[Index].infoList.length>1">
            <el-button size="mini" class="bottomBGC" v-for="(item,index) in woundInfoHistory[Index].infoList" @click="chooseSmallWound(index)" :key="index">伤口{{index+1}}</el-button>
          </div>
          <el-row class="table">
            <el-col :span="24">伤口类型：{{woundType}}</el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="24">伤口部位信息：{{site}}</el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="24">伤口大小信息：
              <swiper :options="optionsSwiper" ref="mySwiper" class="swiperImg">
                <swiper-slide v-if="info.previousExudatePic"><img :src="info.previousExudatePic"></swiper-slide>
                <swiper-slide v-if="info.beforeDebridePic"><img :src="info.beforeDebridePic"></swiper-slide>
                <swiper-slide v-if="info.afterDebridePic"><img :src="info.afterDebridePic"></swiper-slide>
                <swiper-slide v-if="info.referencePic"><img :src="info.referencePic"></swiper-slide>
                <swiper-slide v-if="info.nearWoundPic"><img :src="info.nearWoundPic"></swiper-slide>
                <swiper-slide v-if="info.farWoundPic"><img :src="info.farWoundPic"></swiper-slide>
                <swiper-slide v-if="info.afterDressingPic"><img :src="info.afterDressingPic"></swiper-slide>
                <swiper-slide v-if="info.afterDressingPic2"><img :src="info.afterDressingPic2"></swiper-slide>
                <swiper-slide v-if="info.dressingPackagePic"><img :src="info.dressingPackagePic"></swiper-slide>
                <swiper-slide v-if="info.otherProcessImg"><img :src="info.otherProcessImg"></swiper-slide>
                <div class="swiper-pagination" slot="pagination"></div>
              </swiper>
              <div class="sickWoundInfo" v-if="info">
                <el-row>
                  <el-col :span="8">
                    长：
                      <span v-if="info.length">{{info.length}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    宽：
                      <span v-if="info.width">{{info.width}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    面积：
                    <span v-if="info.area">{{info.area}}cm <sup>2</sup>(仅参考)</span>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    深度：
                    <span v-if="info.depth">{{info.depth}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    体积：<span v-if="info.volume">{{info.volume}}cm<sup>3</sup>(仅参考)</span>
                  </el-col>
                  <el-col :span="8">
                    切口总长：
                    <span v-if="info.sutureLength">{{info.sutureLength}}cm </span>
                    <span v-if="!info.sutureLength">无 </span>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    <div style="display:flex;">
                        <div>
                          <p style="margin:0">潜行：</p>
                        </div>
                        <div>
                          <p style="margin:0" v-if="one">无</p>
                          <p style="margin:0" v-if="!one">
                          <span>{{info.sneakType}}</span>
                          <span v-if="info.sneakStart || info.sneakEnd">
                            <span>{{info.sneakStart}}</span>点到<span>{{info.sneakEnd}}</span>点
                          </span>
                          </p>
                          <p style="margin:0" v-if="!one&&info.sneakRemark">备注：<span>{{info.sneakRemark}}</span></p>
                          <p style="margin:0"  v-if="!one" v-for="(item,index) in info.sneakList" :key="index">{{item.startPoint}}点，长度{{item.length}}cm</p>
                        </div>
                    </div>
                  </el-col>
                  <el-col :span="8">
                    <div style="display:flex;">
                        <div>
                          <p style="margin:0">窦道：</p>
                        </div>
                        <div>
                        <p style="margin:0" v-if="two">无</p>
                        <p style="margin:0" v-if="!two">
                          <span>{{info.sinusType}}</span>
                          <span v-if="info.sinusStart || info.sinusEnd">
                            <span>{{info.sinusStart}}</span>点到<span>{{info.sinusEnd}}</span>点
                          </span>
                          </p>
                          <p style="margin:0" v-if="!two&&info.sinusRemark">备注：<span>{{info.sinusRemark}}</span></p>
                          <p style="margin:0" v-if="!two" v-for="(item,index) in info.sinusList" :key="index">{{item.startPoint}}点，长度{{item.length}}cm</p>
                        </div>
                    </div>
                  </el-col>
                  <el-col :span="8">
                    <div style="display:flex;">
                        <div>
                          <p style="margin:0">瘘管：</p>
                        </div>
                        <div>
                          <p style="margin:0" v-if="three">无</p>
                          <p style="margin:0" v-else v-for="(item,index) in info.fistulaList" :key="index">{{item.startPoint}}点,备注{{item.remark}}，长度{{item.length}}cm</p>
                        </div>
                    </div>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    创面组织成分：
                  </el-col>
                  <el-col :span="8">
                    坏死（黑色）：{{info.black}}%{{info.blackChildren}}
                  </el-col>
                  <el-col :span="8">
                    腐肉（黄色）：{{info.yellow}}%{{info.yellowChildren}}
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    &nbsp;
                  </el-col>
                  <el-col :span="8">
                    肉芽（红色）：{{info.red}}% <br>
                    {{info.redChildren}}
                  </el-col>
                  <el-col :span="8">
                    上皮（粉红）：{{info.pink}}%
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="15" :offset="8">
                    备注：{{info.woundBedRemark}}
                  </el-col>
                </el-row>
              </div>
            </el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">渗液颜色性状：<span v-if="info.penetrationColor">{{info.penetrationColor}}</span></el-col>
            <el-col :span="9" :offset="3">渗液(量)：<span v-if="info.penetrationQuantity">{{info.penetrationQuantity}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">气味：<span v-if="info.smell">{{info.smell}}</span></el-col>
            <el-col :span="9" :offset="3">伤口边缘：<span v-if="info.woundEdge">{{info.woundEdge}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="24">创面疼痛频率和程度： <span v-if="info.painLevel">{{info.painLevel}}分,{{info.painkillers}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">清洗：<span v-if="info.debrideLiquid">{{info.debrideLiquid}}</span></el-col>
            <el-col :span="9" :offset="3">清创：<span v-if="info.debrideWay">{{info.debrideWay}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">辅助治疗：<span v-if="info.assistTherapy">{{info.assistTherapy}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">敷料种类：<span v-if="info.dressingTypeNew">{{info.dressingTypeNew}}</span></el-col>
            <el-col :span="9" :offset="3">敷料名称：<span v-if="info.dressingIdNew">{{info.dressingIdNew}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">其他处理方式：<span v-if="info.otherProcess">{{info.otherProcess}}</span></el-col>
          </el-row>
          <el-row class="table">
            <el-col :span="9">处理护士：{{info.nurseTitle}}
              <!-- <img v-if="info.nurseName" style="width:50px;height:50px;" :src="info.nurseName" alt=""> -->
            </el-col>
          </el-row>
        </template>
      </div>
    </div>
    <Foot v-show="!isFocus" :index="index" id="Foot" :save="save"></Foot>
  </div>
</template>

<script>
import Foot from "../../components/footer"
export default {
  name:'sickMessage',
  components:{Foot},
  data(){
    return {
      isFocus: false,
      save:false,
      one:false,
      two:false,
      three:false,
      loading:false,
      site:'',
      woundType:'',
      woundType:'',
      info:{},
      elseWord:'',
      index:'1',
      Index:0,
      Index1:0,
      active:true,
      allWoundType:[],
      woundInfoHistory:[],
      sickData:{},
      optionsSwiper:{
        pagination: {
          el: '.swiper-pagination',
          clickable :true,
          dynamicBullets: true,
        },
      },
    }
  },
  computed: {
    swiper() {
      return this.$refs.mySwiper.swiper
    }
  },
  methods:{
    chooseBigWound(index){
      this.Index=index;
      let len=document.getElementsByClassName('buttonBGC').length;
      for(let j=0;j<len;j++){
        document.getElementsByClassName('buttonBGC')[j].style.color='#000';
        document.getElementsByClassName('buttonBGC')[j].style.border='none';
      }
      document.getElementsByClassName('buttonBGC')[index].style.color='#409EFF';
      document.getElementsByClassName('buttonBGC')[index].style.borderBottom='2px solid #409EFF';
      this.Index1=0;
      if(document.getElementsByClassName('bottomBGC').length>0){
        let len=document.getElementsByClassName('bottomBGC').length;
        for(let j=0;j<len;j++){
          document.getElementsByClassName('bottomBGC')[j].style.backgroundColor='rgb(166,166,166)';
        }
        document.getElementsByClassName('bottomBGC')[this.Index1].style.backgroundColor='#409EFF';
      }
      this.site=this.woundInfoHistory[index].site;
      this.woundType=this.woundInfoHistory[index].woundType;
      this.getSpecInfo(index,this.Index1);
    },
    chooseSmallWound(index){
      this.Index1=index;
      let len=document.getElementsByClassName('bottomBGC').length;
      for(let j=0;j<len;j++){
        document.getElementsByClassName('bottomBGC')[j].style.backgroundColor='rgb(166,166,166)';
      }
      document.getElementsByClassName('bottomBGC')[index].style.backgroundColor='#409EFF';
      this.getSpecInfo(this.Index,index);
    },
    getSpecInfo(index,I){
      if(this.woundInfoHistory[index].infoList.length>0){
        this.loading=true;
        this.API.get('/api/wound/record/getHistory',{'infoId':this.woundInfoHistory[index].infoList[I].infoId})
        .then((res)=>{
          if(res.code==0){
            this.info=res.data;
            if(this.info.fistulaList.length>0){
              this.three=false;
            }else{
              this.three=true;
            }
            if(this.info.sinusList.length>0){
              this.two=false;
            }else{
              this.two=true;
            }
            if(this.info.sneakList.length>0){
              this.one=false;
            }else{
              this.one=true;
            };
          }else{
            this.$message({
              type:'info',
              message:res.message,
              duration:1000
            })
          }
        })
        .catch((err)=>{
          this.$message({
            type:'error',
            message:err.message,
            duration:1000
          })
        })
        .finally(()=>{
          this.loading=false;
        })
      }else{
        this.$message({
          type:'info',
          message:'暂无记录',
          duration:1000
        });
        this.info={};
        this.loading=false;
      }
    },
    //顶部标签按钮切换
    Switch(){
      this.active = !this.active
    },
    linkTo(){
      this.$store.commit('setSickMessage',{});
      this.$store.commit('setCardID','');
      this.$store.commit('historySet',[]);
      this.$store.commit('setHistory',[]);
      this.$store.commit('setTempData',[]);
      this.$store.commit('setRecordId',[]);
      this.$store.commit('setTempData1',[]);
      this.$store.commit('setInfoId',[]);
      this.$router.push('/index');
    },
    getInfoList(){
      this.loading = true
      this.API.get('/api/patient/info/getWoundList',{'patientId': this.sickData.id})
      .then((res)=>{
        if (res.code === 0){
          this.woundInfoHistory = res.data
          this.$store.commit('setHistory', res.data)
          if (this.woundInfoHistory.length > 0 && this.woundInfoHistory[0].infoList.length > 0) {
            this.getSpecInfo(0, 0)
            this.site = this.woundInfoHistory[0].site
            this.woundType = this.woundInfoHistory[0].woundType
          } else {
            this.loading = false
          }
        }else{
          this.$message({
            type: 'info',
            message: res.message,
            duration: 1000
          })
          this.loading = false
        }
      })
      .catch((err)=>{
        this.$message({
          type: 'error',
          message: err.message,
          duration: 1000
        })
        this.loading = false
      })
    },
    addSick(){
      let data={
        'id':this.sickData.id,
        'cardId':this.sickData.cardId,
        'ward':this.sickData.ward,
        'bedNo':this.sickData.bedNo,
        'name':this.sickData.name,
        'sex':this.sickData.sex,
        'age':this.sickData.age,
        'diagnosis':this.sickData.diagnosis,
        'surgery':this.sickData.surgery,
        'systemicDisease':this.sickData.systemicDisease,
        'systemicDetail':this.sickData.systemicDetail,
        'hgb':this.sickData.hgb,
        'alb':this.sickData.alb,
        'glu':this.sickData.glu,
        'wsc':this.sickData.wsc,
        'wbc':this.sickData.wbc,
        'plt':this.sickData.plt,
        'esr':this.sickData.esr,
        'crp':this.sickData.crp,
        'examineTime':this.sickData.examineTime,
        'hgbTime':this.sickData.hgbTime,
        'albTime':this.sickData.albTime,
        'gluTime':this.sickData.gluTime,
        'wscTime':this.sickData.wscTime,
        'wbcTime':this.sickData.wbcTime,
        'pltTime':this.sickData.pltTime,
        'esrTime':this.sickData.esrTime,
        'crpTime':this.sickData.crpTime,
        'diseaseResult':this.sickData.diseaseResult,
      }
      this.API.post('/api/patient/info/update',data)
      .then(res=>{
        if(res.code!=0){
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          });
        }
      })
      .catch(err=>{
        this.$message({
          type:'error',
          message:err.message,
          duration:1000
        })
      })
    },
    hideFoot(){
      this.isFocus = true
    },
    showFoot(){
      this.isFocus = false
    }
  },
  beforeDestroy(){
    this.$store.commit('setSickMessage',this.sickData);
    this.addSick();
  },
  created(){
    this.sickData = this.$store.state.sickMessage
    this.getInfoList()
  },
}
</script>

<style>
  #sickMessage{
    /* margin-bottom: 80px; */
    overflow:auto;
    height: 100%;
  }
  #sickMessage .swiperImg img{
    width: 100%;
  }
  #sickMessage .elseInput .el-input__inner{
    border: none;
    border-bottom: 1px solid #ccc;
    border-radius: 0;
    background-color: transparent;
    height: 20px;
    line-height: 20px;
    max-width:70px;
    padding: 0 3px;
  }
  #sickMessage .radioSelect{
    display: block;
    padding: 2px 0 2px 40px;
  }
  #sickMessage .INPUTS .el-input__inner{
    text-align: center;
    border-radius: 0;
    border: none;
    border-bottom: 1px solid #606266;
    padding: 0;
    background: #f2f2f2;
    height: 20px!important;
    line-height: 20px;
  }
  #sickMessage .INPUTS{
    width: 70px;
  }
  #sickMessage .INPUTS .el-input__icon{
    display:none;
  }
  #sickMessage .buttonBGC{
    border: none;
    background-color: #fff;
    color: #000;
    border-radius: 0;
    padding-left: 0;
    padding-right: 0;
  }
  #sickMessage .buttonBGC:nth-child(1){
    color: #409EFF;
    border-bottom: 2px solid #409EFF
  }
  #sickMessage .bottomBGC{
    border: none;
    background-color: rgb(166,166,166);
    color: #fff;
  }
  #sickMessage .bottomBGC:nth-child(1){
    background-color: #409EFF;
  }
  #sickMessage .tableInput .el-input__inner{
    width:120px;
    border: none;
    border-bottom: 1px solid #ccc;
    margin-bottom: 4px;
  }
  #sickMessage .textBreak{
    white-space: normal;
    word-break: break-all;
    word-wrap: break-word;
    display: flex
  }
  #sickMessage .checkboxAdd{
    padding: 5px 10px;
    display: flex;
    height: 20px;
  }
  #sickMessage .jieguo{
    display: flex;
    justify-content: start;
  }
  #sickMessage .jieguo .el-input{
    display: inline-block;

  }
  #sickMessage .jieguo .el-input__inner{
    width:140px;
    border:0;
    border-bottom: 1px solid #ccc;
    text-align: center;
    border-radius: 0;
    height: 30px;
  }
  #sickMessage .el-checkbox__label{
    font-size:14px;
  }
  #sickMessage .sickWoundInfo{
    background-color: #f2f2f2;
    color: #000;
    padding: 5px 5px;
  }
  #sickMessage .flexWound{
    display: flex;
    align-items: center;
  }
  #sickMessage .icon{
    padding-left: 10px
  }
  #sickMessage .addSpanStyle{
    display: inline-flex;
  }
  #siceMEssage .element::-webkit-scrollbar {
    display:none
  }
  #sickMessage .swiper-slide{
    width:auto;
  }
  #sickMessage .woundNum{
    width:100%;
    display: flex;
    overflow: auto;
    padding: 5px 0
  }
  #sickMessage .el-date-editor.el-input, .el-date-editor.el-input__inner{
    width: 100%;
  }
  #sickMessage #Foot{
    position: fixed;
    bottom: 0;
  }
  #sickMessage .updateTime{
    color:red;
    padding-left: 10px;
  }
  #sickMessage h1{
    display: flex;
    align-items: center;
  }
  #sickMessage .tab{
    /* padding-top: 20px; */
    margin-bottom:80px;
    margin-top:120px;
  }
  #sickMessage .left{
    justify-content:flex-start;
  }
  #sickMessage .center{
    width:100%;
  }
  #sickMessage .tabBorder{
    padding: 0 15px;
    border-bottom: 3px solid #2e96e6;
    margin: 0;
    margin-top: 7px;
  }
  #sickMessage .tabList{
    padding:10px 0;
    background-color: #ddd;
    text-align: center;
    border-radius: 10px 10px 0 0;
    color: #666;
    margin: 0 10px;
  }
  #sickMessage .tabActive{
    background-color: #2e96e6;
    color: #fff
  }
  #sickMessage .tabShow{
    text-align: left;
    /* padding-top:20px; */
  }
  #sickMessage .table{
    padding: 10px 0;
    border-bottom:1px solid #ddd;
  }
  #sickMessage .paddingBottom50{
    padding-bottom: 50px;
  }
  #sickMessage .paddingLR20{
    padding-left:20px;
    padding-right:20px;
  }
  #sickMessage .width100{
    display: inline-block;
    width: 100px;
  }
  #sickMessage .width80{
    display: inline-block;
    width: 80px;
  }
  #sickMessage .paddingLR30{
    padding-left: 20px;
    padding-right:20px;
    box-sizing: border-box;
  }
  #sickMessage .paddingTB10{
    padding-top: 10px;
    padding-bottom: 10px;
  }
  #sickMessage .inputStyle{
    outline: none;
    height: 30px;
    border: 1px solid #ccc;
  }
  #sickMessage .textIndent30{
    text-indent: 30px;
  }
  #sickMessage table{
    width:100%;
    text-align: center;
    border-color:#ccc;
    border-collapse: collapse;
    margin-top:20px;
    line-height: 30px;
  }
  #sickMessage .trStyle{
    background-color:#e9e9e9;
    opacity: 0.8;
  }
  #sickMessage .trHeight{
    line-height: 20px;
  }
  #sickMessage .thWeight{
    font-weight: 400;
  }
  #sickMessage .thWeight span{
    font-size: 12px;
  }
  #sickMessage .block{
    display: block;
  }
  #sickMessage .ckeckListStyle{
    background-color: #f2f2f2;
  }
  #sickMessage .lineHeight30{
    line-height: 30px;
  }
</style>
