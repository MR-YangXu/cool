<template>
  <div id="sickWound" v-loading="loading">
    <h1><span @click="backTo"></span><icon style="padding-left:10px;" name="back" width="30" height="30"></icon>{{sickName}}伤口病例历史<span>&nbsp;</span></h1>
    <div class="titleList">
      <el-button size="mini" :style={backgroundColor:titleColor[0]} @click="targetTitle(0)" class="titleButton">伤口图片</el-button>
      <el-button size="mini" :style={backgroundColor:titleColor[1]} @click="targetTitle(1)" class="titleButton">愈合曲线</el-button>
      <el-button size="mini" :style={backgroundColor:titleColor[2]} @click="targetTitle(2)" class="titleButton">患者信息</el-button>
    </div>
    <div class="content">
      <div v-show="mainShow[0]" class="show" style="overflow-y:hidden;height:100%">
        <div class="top">
          <el-select size="mini" class="skSelect" v-model="skSelect" @change="targetSelect">
            <el-option v-for="item in typeList" :key="item.woundId" :label="item.woundNameSimple" :value="item.woundId"></el-option>
          </el-select>
          <el-tabs v-model="activeName" class="skTabs">
            <el-tab-pane label="渗液情况" name="first"></el-tab-pane>
            <el-tab-pane label="清创前伤口" name="second"></el-tab-pane>
            <el-tab-pane label="清创后伤口" name="third"></el-tab-pane>
          </el-tabs>
        </div>
        <div class="main" style="overflow-y:auto;height:calc(100% - 60px)">
          <div class="years" v-for="item in imgList" :key="item.year">
            <p>{{item.year}}年</p>
            <el-row>
              <el-col style="margin:5px 0;" v-for="items in item.imageList" :key="items.recordId" :span='8'>
                <div style="box-sizing:border-box;padding:0 4px;">
                  <div style="height:120px">
                    <img v-show="activeName=='first'"  @click="viewInfo(items.recordId,item.year,items.createTime,items.countDay)" :src="items.previousExudatePic">
                    <img v-show="activeName=='second'"  @click="viewInfo(items.recordId,item.year,items.createTime,items.countDay)" :src="items.beforeDebridePic">
                    <img v-show="activeName=='third'"  @click="viewInfo(items.recordId,item.year,items.createTime,items.countDay)" :src="items.afterDebridePic">
                  </div>
                  <div style="background-color:#d9d9d9;">
                    <p style="margin:0">{{items.createTime}} 接诊第{{items.countDay}}天</p>
                  </div>
                </div>
              </el-col>
            </el-row>
          </div>
        </div>
      </div>
      <div v-show="mainShow[1]" v-if="typeList.length>0" id="show1" style="height:100%;overflow-y:hidden"  @touchstart="getTouchX"  @touchend="autoRefreshData">
        <div class="tabSite">
          <el-tabs v-model="activeName1" @tab-click="tabClick">
            <el-tab-pane v-for="(item,index) in typeList" :key="item.id" :label="item.woundNameSimple" :name="String(index)"></el-tab-pane>
          </el-tabs>
        </div>
        <div class="btnSet">
          <div class="btnDiv" v-if="show3">
            <el-select v-model="padun" @change="getCanvasData" size="small">
              <el-option v-for="(item,index) in changeData" :key="index" :value="index" :label="item.woundName"></el-option>
            </el-select>
          </div>
          <div class="btnDiv" style="padding:10px 0;">
            <p style="width:50%;text-align:left;padding-left:30px;margin:0;float:right">请点击下方面积，渗液量，创面组织类型色条，显示相关参数愈合曲线。</p>
          </div>
          <div v-if="changeData.conversionResult" style="background-color:#ccc;text-align:left;padding:2px 10px;">
            <p v-for="(item,index) in changeData.conversionResult" :key="index">{{item}}</p>
          </div>
          <div class="btnDiv">
            <el-button v-if="typeList[Number(activeName1)].secondWoundType==19" class="btnLi btnAll" @click="viewAll" size="mini" :style="{backgroundColor:allBGC,color:allColor}"> 总体 </el-button>
          </div>
          <div class="btnDiv">
            <el-button class="btnLi btnAreas" @click="viewAreas" size="mini" :style="{backgroundColor:areasBGC,color:areasColor}"> 面积 </el-button>
          </div>
          <div class="btnDiv">
            <el-button class="btnLi btnSeepage" @click="viewSeepage" size="mini" :style="{backgroundColor:seepageBGC,color:seepageColor}">渗液量</el-button>
          </div>
          <div class="btnDiv">
            <el-button class="btnLi btnType" @click="viewType" size="mini" :style="{backgroundColor:typeBGC,color:typeColor}">创面组织类型</el-button>
          </div>
          <div class="btnDiv">
            <el-button class="btnLi btnPain" @click="viewPain" size="mini" :style="{backgroundColor:painBGC,color:painColor}">疼痛度</el-button>
          </div>
        </div>
      </div>
      <div v-show='mainShow[2]' class="show">
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
    </div>
    <Foot v-show="!isFocus" id="Foot" :index="index" :save="save"></Foot>

    <el-dialog :title="year+'年'+time+'接诊第'+day+'天伤口图片与评估处理记录'" style="z-index:10" :visible.sync="dialogVisible" width="95%" center :show-close="false" :close-on-click-modal="false" :close-on-press-escape="false">
      <div v-if="info.length>0">
        <div v-if="info.length>1">
          <el-button size="mini" class="diaButton" :style="{backgroundColor:diaColor[index]}" v-for="(item,index) in info" :key="index" @click="targetDia(index)">伤口{{index+1}}</el-button>
        </div>
        <el-row class="table">
          <el-col :span="24">
              <swiper :options="optionsSwiper" ref="swiper" class="swiperImg swiper-container-horizontal">
                <swiper-slide v-if="info[padun].previousExudatePic"><img :src="info[padun].previousExudatePic"  @click="handleLookImg(info[padun].previousExudatePic)"></swiper-slide>
                <swiper-slide v-if="info[padun].beforeDebridePic"><img :src="info[padun].beforeDebridePic"  @click="handleLookImg(info[padun].beforeDebridePic)"></swiper-slide>
                <swiper-slide v-if="info[padun].afterDebridePic"><img :src="info[padun].afterDebridePic"  @click="handleLookImg(info[padun].afterDebridePic)"></swiper-slide>
                <swiper-slide v-if="info[padun].referencePic"><img :src="info[padun].referencePic"  @click="handleLookImg(info[padun].referencePic)"></swiper-slide>
                <swiper-slide v-if="info[padun].nearWoundPic"><img :src="info[padun].nearWoundPic"  @click="handleLookImg(info[padun].nearWoundPic)"></swiper-slide>
                <swiper-slide v-if="info[padun].farWoundPic"><img :src="info[padun].farWoundPic"  @click="handleLookImg(info[padun].farWoundPic)"></swiper-slide>
                <swiper-slide v-if="info[padun].afterDressingPic"><img :src="info[padun].afterDressingPic"  @click="handleLookImg(info[padun].afterDressingPic)"></swiper-slide>
                <swiper-slide v-if="info[padun].afterDressingPic2"><img :src="info[padun].afterDressingPic2"  @click="handleLookImg(info[padun].afterDressingPic2)"></swiper-slide>
                <swiper-slide v-if="info[padun].dressingPackagePic"><img :src="info[padun].dressingPackagePic"  @click="handleLookImg(info[padun].dressingPackagePic)"></swiper-slide>
                <swiper-slide v-if="info[padun].otherProcessImg"><img :src="info[padun].otherProcessImg"  @click="handleLookImg(info[padun].otherProcessImg)"></swiper-slide>
                <div class="swiper-pagination" slot="pagination"></div>
              </swiper>
              <div class="sickWoundInfo" v-if="info">
                <el-row>
                  <el-col :span="8">
                    长：<span v-if="info[padun].length">{{info[padun].length}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    宽：<span v-if="info[padun].width">{{info[padun].width}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    面积：<span v-if="info[padun].area">{{info[padun].area}}cm <sup>2</sup>(仅参考)</span>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    深度：<span v-if="info[padun].depth">{{info[padun].depth}}cm</span>
                  </el-col>
                  <el-col :span="8">
                    体积：<span v-if="info[padun].volume">{{info[padun].volume}}cm<sup>3</sup>(仅参考)</span>
                  </el-col>
                  <el-col :span="8">
                    切口总长：<span v-if="info[padun].sutureLength">{{info[padun].sutureLength}}cm </span>
                        <span v-if="!info[padun].sutureLength">无 </span>
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
                            <span>{{info[padun].sneakType}}</span>
                            <span v-if="info[padun].sneakStart || info[padun].sneakEnd">
                              <span>{{info[padun].sneakStart}}</span>点到<span>{{info[padun].sneakEnd}}</span>点
                            </span>
                          </p>
                          <p style="margin:0" v-if="!one&&info[padun].sneakRemark">备注：<span>{{info[padun].sneakRemark}}</span></p>
                          <p style="margin:0" v-if="!one" v-for="(item,index) in info[padun].sneakList" :key="index">{{item.startPoint}}点，长度{{item.length}}cm</p>
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
                            <span>{{info[padun].sinusType}}</span>
                            <span v-if="info[padun].sinusStart || info[padun].sinusEnd">
                              <span>{{info[padun].sinusStart}}</span>点到<span>{{info[padun].sinusEnd}}</span>点
                            </span>
                          </p>
                          <p style="margin:0" v-if="!two&&info[padun].sinusRemark">备注：<span>{{info[padun].sinusRemark}}</span></p>
                          <p style="margin:0" v-if="!two" v-for="(item,index) in info[padun].sinusList" :key="index">{{item.startPoint}}点，长度{{item.length}}cm</p>
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
                          <p style="margin:0" v-else v-for="(item,index) in info[padun].fistulaList" :key="index">{{item.startPoint}}点,备注{{item.remark}}，长度{{item.length}}cm</p>
                        </div>
                    </div>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    创面组织成分：
                  </el-col>
                  <el-col :span="8">
                    坏死（黑色）：{{info[padun].black}}%{{info[padun].blackChildren}}

                  </el-col>
                  <el-col :span="8">
                    腐肉（黄色）：{{info[padun].yellow}}%{{info[padun].yellowChildren}}

                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="8">
                    &nbsp;
                  </el-col>
                  <el-col :span="8">
                    肉芽（红色）：{{info[padun].red}}%<br>
                    {{info[padun].redChildren}}
                  </el-col>
                  <el-col :span="8">
                    上皮（粉红）：{{info[padun].pink}}%
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="15" :offset="8">
                    备注：{{info[padun].woundBedRemark}}
                  </el-col>
                </el-row>
              </div>
          </el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">渗液颜色性状：<span v-if="info[padun].penetrationColor">{{info[padun].penetrationColor}}</span></el-col>
          <el-col :span="9" :offset="3">渗液(量)：<span v-if="info[padun].penetrationQuantity">{{info[padun].penetrationQuantity}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">气味：<span v-if="info[padun].smell">{{info[padun].smell}}</span></el-col>
          <el-col :span="9" :offset="3">伤口边缘：<span v-if="info[padun].woundEdge">{{info[padun].woundEdge}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="24">创面疼痛频率和程度： <span v-if="info[padun].painLevel">{{info[padun].painLevel}}分,{{info[padun].painkillers}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">清洗：<span v-if="info[padun].debrideLiquid">{{info[padun].debrideLiquid}}</span></el-col>
          <el-col :span="9" :offset="3">清创：<span v-if="info[padun].debrideWay">{{info[padun].debrideWay}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">辅助治疗：<span v-if="info[padun].assistTherapy">{{info[padun].assistTherapy}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">敷料种类：<span v-if="info[padun].dressingTypeNew">{{info[padun].dressingTypeNew}}</span></el-col>
          <el-col :span="9" :offset="3">敷料名称：<span v-if="info[padun].dressingIdNew">{{info[padun].dressingIdNew}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">其他处理方式：<span v-if="info[padun].otherProcess">{{info[padun].otherProcess}}</span></el-col>
        </el-row>
        <el-row class="table">
          <el-col :span="9">处理护士：{{info[padun].nurseTitle}}
            <!-- <img v-if="info[padun].nurseName" style="width:50px;height:50px" :src="info[padun].nurseName" alt=""> -->
            </el-col>
        </el-row>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" type="primary" @click="closeDia">关 闭</el-button>
      </span>
    </el-dialog>

    <img :src="lookImgSrc"
     v-if="lookImgShow"
     style="width:100%;position:fixed;top:0;left:0;bottom:0;right:0;z-index:10000000;background:#b4b4b4;"
     @click="handleCloselookImg">
  </div>
</template>

<script>
// import * as d3 from 'd3'
import Foot from '../../components/footer'
export default {
  name:'sickWound',
  components:{Foot},
  data(){
    return{
      isFocus: false,
      lookImgShow:false,
      lookImgSrc:null,
      save:false,
      one:true,
      two:true,
      three:true,
      foo:true,
      buttunName:1,
      Size:[],
      X:0,
      X1:0,
      pn:1,
      show3:false,
      allBGC:'none',
      allColor:'#be0000',
      areasBGC:'none',
      areasColor:'#68c847',
      seepageBGC:'none',
      seepageColor:'#2e96e6',
      typeBGC:'none',
      typeColor:'#b45fa6',
      painBGC:'none',
      painColor:'#c45a11',
      changeData:[],
      totalScore:[],
      areaScore:[],
      area:[],
      num:1,
      penetrationQuantityScore:[],
      penetrationQuantity:[],
      woundScore:[],
      painLevel:[],
      createTime:[],
      allWoundInfo:[],
      activeName1:'0',
      sickData:{},
      old:false,
      loading:false,
      index:'4',
      sickName:'',
      path:'',
      titleColor:['#409EFF','rgb(166,166,166)','rgb(166,166,166)'],
      diaColor:[],
      mainShow:[true,false,false],
      skSelect:'',
      activeName:'first',
      typeList:[],
      imgList:[],
      year:'',
      time:'',
      day:'',
      dialogVisible:false,
      info:[],
      padun:0,
      optionsSwiper:{
        pagination: {
          el: '.swiper-pagination',
          clickable :true,
          dynamicBullets: true,
        },
      },
    }
  },
  methods:{
    //查看大图
    handleLookImg(val){
       this.lookImgShow = true
       this.lookImgSrc = val
    },
    //关闭查看大图
    handleCloselookImg(){
      this.lookImgShow = false
      this.lookImgSrc = null
    },
    targetSelect(val){
      this.getImageList();
    },
    // 聚焦隐藏底部栏
    hideFoot(){
      this.isFocus = true
    },
    // 失焦显示底部栏
    showFoot(){
      this.isFocus = false
    },
    // 回退到上个页面
    backTo(){
      // if(this.path==undefined){
      //   this.path='/searchArchive'
      // }
      // this.$router.push({
      //   path:this.path
      // })
      this.$router.go(-1)
    },
    //切换按钮
    targetTitle(index){
      this.padun=0;
      this.activeName1='0';
      if(index==1){
        this.getAllChange(this.typeList[0].woundId);
      }else if(index==2){
        if(this.old){
          this.sickData=this.$store.state.sickMessage
        }else{
          this.getInfo();
        }
      }
      this.$set(this.titleColor,index,'#409EFF');
      this.$set(this.mainShow,index,true);
      for(let i=0;i<3;i++){
        if(i!=index){
          this.titleColor[i]='rgb(166,166,166)';
          this.mainShow[i]=false;
        }
      };
    },
    //根据伤口查询信息
    getImageList(){
      this.loading=true;
      this.API.get('/api/search/getImageList',{'woundId':this.skSelect})
      .then((res)=>{
        if(res.code==0){
          this.imgList=res.data;
        }else{
          this.$messages({
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
    },
    //点击图片查看患者记录
    viewInfo(id,year,time,day){
      this.loading=true;
      this.API.get('/api/search/getHistory',{'recordId':id})
      .then((res)=>{
        if(res.code==0){
          this.info=res.data;
          if(this.info[this.padun].fistulaList.length>0){
            this.three=false;
          }else{
            this.three=true;
          }
          if(this.info[this.padun].sinusList.length>0){
            this.two=false;
          }else{
            this.two=true;
          }
          if(this.info[this.padun].sneakList.length>0){
            this.one=false;
          }else{
            this.one=true;
          };
          this.year=year;
          this.time=time;
          this.day=day;
          this.info.forEach((val,index)=>{
            if(index==0){
              this.$set(this.diaColor,index,'#409EFF')
            }else{
              this.$set(this.diaColor,index,'rgb(166,166,166)')
            }

          })
          this.dialogVisible=true;
        }else{
          this.$messages({
            type:'info',
            message:res.message
          })
        }
      })
      .catch((err)=>{
        this.$messages({
          type:'error',
          message:err.message
        })
      })
      .finally(()=>{
        this.loading=false;
      })
    },
    //切换多个临近伤口
    targetDia(index){
      this.padun=index;
      if(this.info[this.padun].fistulaList.length>0){
        this.three=false;
      }else{
        this.three=true;
      }
      if(this.info[this.padun].sinusList.length>0){
        this.two=false;
      }else{
        this.two=true;
      }
      if(this.info[this.padun].sneakList.length>0){
        this.one=false;
      }else{
        this.one=true;
      };
      this.diaColor[index]='#409EFF';
      this.diaColor.forEach((val,i)=>{
        if(i!=index){
          this.diaColor[i]='rgb(166,166,166)'
        }
      })
    },
    //关闭dia
    closeDia(){
      this.padun=0;
      this.dialogVisible=false;
    },
    //画图
    getTouchX(e){
      this.X=e.touches[0].clientX;
    },
    autoRefreshData(e){
      this.X1=e.changedTouches[0].clientX;
      if(this.X1-this.X>=50){
        this.pn++;

        if(this.pn>this.Size[Number(this.padun)]){
          this.pn--;
          this.$message({
            type:'info',
            message:'没有更多数据了',
            duration:1000
          })
        }else{
          this.foo=false;
          this.getAllChange(this.typeList[Number(this.activeName1)].woundId);
        }
        this.X=0;
        this.X1=0;
      }else if(this.X-this.X1>=50){
        this.pn--;
        if(this.pn>0){
          this.foo=false;
          this.getAllChange(this.typeList[Number(this.activeName1)].woundId);
        }else{
          this.pn++;
          this.$message({
            type:'info',
            message:'已经是最新的数据了',
            duration:1000
          })
        };
        this.X=0;
        this.X1=0;
      }
    },
    //查看总体变化
    viewAll(){
      this.buttunName=1;
      this.allBGC='#be0000';
      this.allColor='#fff';
      this.areasBGC='#fff';
      this.areasColor='#68c847';
      this.seepageBGC='#fff';
      this.seepageColor='#2e96e6';
      this.typeBGC='#fff';
      this.typeColor='#b45fa6';
      this.painBGC='#fff';
      this.painColor='#c45a11';
      d3.selectAll('.pp').remove();
      this.color='#be0000';
      this.num=1;
      this.canvas('愈合分数',this.totalScore,this.createTime,this.len,this.num)
    },
    //查看面积变化
    viewAreas(){
      this.buttunName=2;
      this.allBGC='#fff';
      this.allColor='#be0000';
      this.areasBGC='#68c847';
      this.areasColor='#fff';
      this.seepageBGC='#fff';
      this.seepageColor='#2e96e6';
      this.typeBGC='#fff';
      this.typeColor='#b45fa6';
      this.painBGC='#fff';
      this.painColor='#c45a11';
      d3.selectAll('.pp').remove();
      this.color='#68c847';
      this.num=0;
      this.canvas('面积',this.areaScore,this.createTime,this.len,this.num,this.area)
    },
    //查看渗液量变化
    viewSeepage(){
      this.buttunName=3;
      this.allBGC='#fff';
      this.allColor='#be0000';
      this.areasBGC='#fff';
      this.areasColor='#68c847';
      this.seepageBGC='#2e96e6';
      this.seepageColor='#fff';
      this.typeBGC='#fff';
      this.typeColor='#b45fa6';
      this.painBGC='#fff';
      this.painColor='#c45a11';
      this.color='#2e96e6';
      this.num=0;
      d3.selectAll('.pp').remove();
      this.canvas('渗液量',this.penetrationQuantityScore,this.createTime,this.len,this.num,this.penetrationQuantity)
    },
    //查看类型变化
    viewType(){
      this.buttunName=4;
      this.allBGC='#fff';
      this.allColor='#be0000';
      this.areasBGC='#fff';
      this.areasColor='#68c847';
      this.seepageBGC='#fff';
      this.seepageColor='#2e96e6';
      this.typeBGC='#b45fa6';
      this.typeColor='#fff';
      this.painBGC='#fff';
      this.painColor='#c45a11';
      this.color='#b45fa6';
      this.num=0;
      d3.selectAll('.pp').remove();
      this.canvas('创面组织成分',this.woundScore,this.createTime,this.len,this.num,this.allWoundInfo)
    },
    //查看痛疼度变化
    viewPain(){
      this.buttunName=5;
      this.allBGC='#fff';
      this.allColor='#be0000';
      this.areasBGC='#fff';
      this.areasColor='#68c847';
      this.seepageBGC='#fff';
      this.seepageColor='#2e96e6';
      this.typeBGC='#fff';
      this.typeColor='#b45fa6';
      this.painBGC='#c45a11';
      this.painColor='#fff';
      this.color='#c45a11';
      this.num=0;
      d3.selectAll('.pp').remove();
      this.canvas('痛疼度',this.painLevel,this.createTime,this.len,this.num)
    },
    //坐标轴
    canvas(name,data,xAxis,len,num,text=null){
      d3.select('.svgarea').remove();
      this.height=window.screen.height-240;
      this.width=window.screen.width;
      this.svg=d3.select('#show1')
        .append('svg');
      this.svg.attr('width',this.width)
          .attr('height',this.height)
          .attr('class','svgarea');
      let ds;
      if(num==1){
        ds=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
      }else{
        ds=[0,1,2,3,4,5,6,7,8,9,10];
      };
      var  min=d3.min(ds),
        max=d3.max(ds),
        //定义比例尺
        linear1 = d3.scaleLinear()
          .domain([min, max])
          .range([this.height-50, 50]),
        linear=d3.scaleBand().range([50, this.width-80])
        .domain(xAxis),
         //定义坐标轴
        axisX=d3.axisBottom().scale(linear),
        axisY=d3.axisLeft(linear1);

        //X坐标轴
      this.svg.append('g')
        .call(axisX)
        .attr('class','gs')
        .attr('transform',"translate(0,"+(this.height-50)+")")
        .attr('stroke-width','1')
        .selectAll('g')
        .attr('class','lj')
        .selectAll('text')
        .attr('font-size','14px');

      //去除标尺刻线长度
      this.svg.selectAll('.gs')
        .selectAll('g')
        .selectAll('line')
        .attr('y2','5');
      //添加轴线名称
      this.svg.selectAll('.gs')
        .append('text')
        .attr("dy", "0.5em")
        .style("text-anchor", "middle")
        .style('font-size','14px')
        .style("fill", "#000")
        .text('日期')
        .attr('transform',"translate("+(this.width-55)+",0)");
      //Y坐标轴
      if(this.typeList[Number(this.activeName1)].secondWoundType==19){
        //
        this.svg.append('g')
        .attr('class','gj')
        .call(axisY)
        .attr('transform','translate(50,0)')
        .attr('stroke-width','1')
        .selectAll('g')
        .selectAll('text')
        .style('font-size','14px');
        //刻度线
         this.svg.selectAll('.gj')
        .selectAll('g')
        .selectAll('line')
        .attr('x2','-5');
        //添加轴线名称
        this.svg.selectAll('.gj')
        .append('text')
        .attr("dy", "0em")
        .style("text-anchor", "middle")
        .style('font-size','14px')
        .style("fill", "#000")
        .text('愈合分数')
        .attr('transform',"translate(0,"+(35)+")");
      }else{
        if(name=='痛疼度'){
          this.svg.append('g')
          .attr('class','gj')
          .call(axisY)
          .attr('transform','translate(50,0)')
          .attr('stroke-width','1')
          .selectAll('g')
          .selectAll('text')
          .style('font-size','14px');
          this.svg.selectAll('.gj')
          .selectAll('g')
          .selectAll('line')
          .attr('x2','-5');
          //添加轴线名称
          this.svg.selectAll('.gj')
          .append('text')
          .attr("dy", "0em")
          .style("text-anchor", "middle")
          .style('font-size','14px')
          .style("fill", "#000")
          .text('愈合分数')
          .attr('transform',"translate(0,"+(35)+")");

        }else{
          this.svg.append('g')
          .attr('class','gj')
          .call(axisY)
          .attr('transform','translate(50,0)')
          .attr('stroke-width','1')
          .selectAll('g')
          .selectAll('text')
          .style('font-size','14px')
          .style('color','#fff');
          this.svg.selectAll('.gj')
          .selectAll('g')
          .selectAll('line')
          .attr('x2','0');
          //添加轴线名称
          this.svg.selectAll('.gj')
          .append('text')
          .attr("dy", "0em")
          .style("text-anchor", "middle")
          .style('font-size','14px')
          .style("fill", "#000")
          .text(name)
          .attr('transform',"translate(0,"+(35)+")");
        }

      }
      //画图
      this.drawing(name,data,len,num,text);
    },
    //图像生成
    drawing(name,data,n,num,text=null){
      this.pointX=[];
      this.pointY=[];
      this.point=[];
      this.pointXu=[];
      let sub=0;
      if(num==1){
        sub=28;
      }else if(num==0){
        sub=10;
      }
      // //定义路径
      var line= d3.line()//线段生成器
      .x((d,i)=>{
          return d.x
        }
      )
      .y((d,i)=>{
          return d.y
        }
      );
      if(this.typeList[Number(this.activeName1)].secondWoundType!=19&&name=='创面组织成分'){
        let color=['#fff','#fff','#fff',"#fff"],
          pre=0,
          sum=0;
        for(let j=0;j<data.length;j++){
          sum=0;
          pre=0;
          color=['#fff','#fff','#fff',"#fff"];
          text[j].forEach((val,index)=>{
            if(Number(val)/25==0){
              pre++;
            }else if(Number(val)/25==1){
              if(index==0){
                color[sum]='black';
              }else if(index==1){
                if(pre>0){
                  pre=0;
                }
                color[sum]='yellow';
              }else if(index==2){
                if(pre>0){
                  pre=0;
                }
                color[sum]='red';
              }else if(index==3){
                if(pre>0){
                  pre=0;
                }
                color[sum]='pink';
              }
              sum++;
            }else if(Number(val)/25==2){
              if(index==0){
                color[0]='black';
                color[1]='black';
              }else if(index==1){
                if(pre>0){
                  pre=0;
                }
                color[sum]='yellow';
                color[sum+1]='yellow';
              }else if(index==2){
                if(pre>0){
                  pre=0;
                }
                color[sum]='red';
                color[sum+1]='red';
              }else if(index==3){
                if(pre>0){
                  pre=0;
                }
                color[sum]='pink';
                color[sum+1]='pink';
              }
              sum=sum+2;
            }else if(Number(val)/25==3){
              if(index==0){
                color[0]='black';
                color[1]='black'
                color[2]='black'
              }else if(index==1){
                if(pre>0){
                  color[0]='yellow';
                  color[1]='yellow'
                  color[2]='yellow'
                  pre=0;
                }else{
                  color[1]='yellow';
                  color[2]='yellow'
                  color[3]='yellow'
                }
              }else if(index==2){
                if(pre>0){
                  if(pre==1){
                    color[1]='red';
                    color[2]='red';
                    color[3]='red';
                  }
                  pre=0;
                }else{
                  if(sum>0){
                    color[1]='red';
                    color[2]='red';
                    color[3]='red';
                  }else{
                    color[0]='red';
                    color[1]='red';
                    color[2]='red';
                  }
                }
              }else if(index==3){
                if(pre>0){
                  color[1]='pink';
                  color[2]='pink';
                  color[3]='pink';
                  pre=0;
                }else{
                  if(sum>0){
                    color[1]='pink';
                    color[2]='pink';
                    color[3]='pink';
                  }else{
                    color[0]='pink';
                    color[1]='pink';
                    color[2]='pink';
                  }
                }
              };
              sum=sum+3;
            }else if(Number(val)/25==4){
              if(index==0){
                color[0]='black';
                color[1]='black';
                color[2]='black';
                color[3]='black';
              }else if(index==1){
                color[0]='yellow';
                color[1]='yellow';
                color[2]='yellow';
                color[3]='yellow';
              }else if(index==2){
                color[0]='red';
                color[1]='red';
                color[2]='red';
                color[3]='red';
              }else if(index==3){
                color[0]='pink';
                color[1]='pink';
                color[2]='pink';
                color[3]='pink';
              }
            }
          })
          var g=this.svg.append('g').attr('class','pp');
          g.selectAll('rect')
          .data(text[j])
          .enter()
          .append('rect')
          .attr('x',(d,i)=>{
            return (j+0.5)*((this.width-130)/n)+40
          })
          .attr('y',(d,i)=>{
            return (this.height-80)-i*35
          })
          .attr('width',20)
          .attr('height',30)
          .attr('fill',(d,i)=>{
            return color[i]
          });
          let tSpan=g.selectAll('text')
              .data(data)
              .enter()
              .append('text')
              .attr('class','targetText')
              .attr('x',(d,i)=>{
                return (i+0.5)*((this.width-130)/n)+50
              })
              .attr('y',(d,i)=>{
                return this.height-d*((this.height-100)/sub)-65
              });
              for(let j=0;j<text.length;j++){
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+30
                  })
                  .attr('y',(d,i)=>{
                    return this.height-255
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(上皮${text[j][3]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+30
                  })
                  .attr('y',(d,i)=>{
                    return this.height-240
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(肉芽${text[j][2]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+30
                  })
                  .attr('y',(d,i)=>{
                    return this.height-225
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(腐肉${text[j][1]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+30
                  })
                  .attr('y',(d,i)=>{
                    return this.height-210
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(坏死${text[j][0]}%)`
                    }
                  })
                  .style('font-size','12px');
              }
        }
      // let color=['#fff','#fff','#fff',"#fff"],
        //   pre=0,
        //   sum=0;
        // for(let j=0;j<data.length;j++){
        //   sum=0;
        //   pre=0,
        //   text[j].forEach((val,index)=>{
        //     if(Number(val)/25==0){
        //       pre++;
        //     }else if(Number(val)/25==1){
        //       if(index==0){
        //         color[sum]='black';
        //       }else if(index==1){
        //         if(pre>0){
        //           color[sum]='yellow';
        //           pre=0;
        //         }else{
        //           color[sum]='yellow';
        //         }
        //       }else if(index==2){
        //         if(pre>0){
        //           color[sum]='red'
        //           pre=0;
        //         }else{
        //           color[sum]='red';
        //         }
        //       }else if(index==3){
        //         if(pre>0){
        //           color[sum]='pink';
        //           pre=0;
        //         }else{
        //           color[sum]='pink';
        //         }
        //       }
        //       sum++;
        //     }else if(Number(val)/25==2){
        //       if(index==0){
        //         color[0]='black';
        //         color[1]='black';
        //       }else if(index==1){
        //         if(pre>0){
        //           color[sum]='yellow';
        //           color[sum+1]='yellow';
        //           pre=0;
        //         }else{
        //           color[sum]='yellow';
        //           color[sum+1]='yellow';
        //         }
        //       }else if(index==2){
        //         if(pre>0){
        //           color[sum]='red';
        //           color[sum+1]='red';
        //           pre=0;
        //         }else{
        //           color[sum]='red';
        //           color[sum+1]='red';
        //         }
        //       }else if(index==3){
        //         if(pre>0){
        //           color[sum]='pink';
        //           color[sum+1]='pink';
        //           pre=0;
        //         }else{
        //           color[sum]='pink';
        //           color[sum+1]='pink';
        //         }
        //       }
        //       sum=sum+2;
        //     }else if(Number(val)/25==3){
        //       if(index==0){
        //         color[0]='black';
        //         color[1]='black'
        //         color[2]='black'
        //       }else if(index==1){
        //         if(pre>0){
        //           color[0]='yellow';
        //           color[1]='yellow'
        //           color[2]='yellow'
        //           pre=0;
        //         }else{
        //           color[1]='yellow';
        //           color[2]='yellow'
        //           color[3]='yellow'
        //         }
        //       }else if(index==2){
        //         if(pre>0){
        //           if(pre==1){
        //             color[1]='red';
        //             color[2]='red';
        //             color[3]='red';
        //           }
        //           pre=0;
        //         }else{
        //           if(sum>0){
        //             color[1]='red';
        //             color[2]='red';
        //             color[3]='red';
        //           }else{
        //             color[0]='red';
        //             color[1]='red';
        //             color[2]='red';
        //           }
        //         }
        //       }else if(index==3){
        //         if(pre>0){
        //           color[1]='pink';
        //           color[2]='pink';
        //           color[3]='pink';
        //           pre=0;
        //         }else{
        //           if(sum>0){
        //             color[1]='pink';
        //             color[2]='pink';
        //             color[3]='pink';
        //           }else{
        //             color[0]='pink';
        //             color[1]='pink';
        //             color[2]='pink';
        //           }

        //         }
        //       };
        //       sum=sum+3;
        //     }else if(Number(val)/25==4){
        //       if(index==0){
        //         color[0]='black';
        //         color[1]='black';
        //         color[2]='black';
        //         color[3]='black';
        //       }else if(index==1){
        //         color[0]='yellow';
        //         color[1]='yellow';
        //         color[2]='yellow';
        //         color[3]='yellow';
        //       }else if(index==2){
        //         color[0]='red';
        //         color[1]='red';
        //         color[2]='red';
        //         color[3]='red';
        //       }else if(index==3){
        //         color[0]='pink';
        //         color[1]='pink';
        //         color[2]='pink';
        //         color[3]='pink';
        //       }
        //     }
        //   })
        //   var g=this.svg.append('g').attr('class','pp');
        //   g.selectAll('rect')
        //   .data(text[j])
        //   .enter()
        //   .append('rect')
        //   .attr('x',(d,i)=>{
        //     return (j+0.5)*((this.width-130)/n)+40
        //   })
        //   .attr('y',(d,i)=>{
        //     return (this.height-80)-i*35
        //   })
        //   .attr('width',20)
        //   .attr('height',30)
        //   .attr('fill',(d,i)=>{
        //     return color[i]
        //   });
        //   let tSpan=g.selectAll('text')
        //       .data(data)
        //       .enter()
        //       .append('text')
        //       .attr('class','targetText')
        //       .attr('x',(d,i)=>{
        //         return (i+0.5)*((this.width-130)/n)+50
        //       })
        //       .attr('y',(d,i)=>{
        //         return this.height-d*((this.height-100)/sub)-65
        //       });
        //       for(let j=0;j<text.length;j++){
        //         tSpan.append('tspan').attr('x',(d,i)=>{
        //             return (j+0.5)*((this.width-130)/n)+30
        //           })
        //           .attr('y',(d,i)=>{
        //             return this.height-255
        //           })
        //           .text((d,i)=>{
        //             if(j==i){
        //               return `(上皮${text[j][3]}%)`
        //             }
        //           })
        //           .style('font-size','12px');
        //         tSpan.append('tspan').attr('x',(d,i)=>{
        //             return (j+0.5)*((this.width-130)/n)+30
        //           })
        //           .attr('y',(d,i)=>{
        //             return this.height-240
        //           })
        //           .text((d,i)=>{
        //             if(j==i){
        //               return `(肉芽${text[j][2]}%)`
        //             }
        //           })
        //           .style('font-size','12px');
        //         tSpan.append('tspan').attr('x',(d,i)=>{
        //             return (j+0.5)*((this.width-130)/n)+30
        //           })
        //           .attr('y',(d,i)=>{
        //             return this.height-225
        //           })
        //           .text((d,i)=>{
        //             if(j==i){
        //               return `(腐肉${text[j][1]}%)`
        //             }
        //           })
        //           .style('font-size','12px');
        //         tSpan.append('tspan').attr('x',(d,i)=>{
        //             return (j+0.5)*((this.width-130)/n)+30
        //           })
        //           .attr('y',(d,i)=>{
        //             return this.height-210
        //           })
        //           .text((d,i)=>{
        //             if(j==i){
        //               return `(坏死${text[j][0]}%)`
        //             }
        //           })
        //           .style('font-size','12px');
        //       }
      // }
      }else{
        //点用圆表示
        var g=this.svg.append('g').attr('class','pp');
        g.selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
        .attr('fill',this.color)
        .attr('cx',(d,i)=>{
          this.pointX.push({'x':((i+0.5)*((this.width-130)/n))+50});
          return (i+0.5)*((this.width-130)/n)+50
        })
        .attr('cy',(d,i)=>{
          this.pointY.push({'y':this.height-50-d*((this.height-100)/sub)});
          return this.height-50-d*((this.height-100)/sub)
        })
        .attr('r',5);
        if(text){
          if(typeof(text[0])=='object'){
            let tSpan=g.selectAll('text')
              .data(data)
              .enter()
              .append('text')
              .attr('class','targetText')
              .attr('x',(d,i)=>{
                return (i+0.5)*((this.width-130)/n)+50
              })
              .attr('y',(d,i)=>{
                return this.height-d*((this.height-100)/sub)-65
              });
              for(let j=0;j<text.length;j++){
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+45
                  })
                  .attr('y',(d,i)=>{
                    return this.height-d*((this.height-100)/sub)-135
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(上皮${text[j][3]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+45
                  })
                  .attr('y',(d,i)=>{
                    return this.height-d*((this.height-100)/sub)-120
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(肉芽${text[j][2]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+45
                  })
                  .attr('y',(d,i)=>{
                    return this.height-d*((this.height-100)/sub)-105
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(腐肉${text[j][1]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+45
                  })
                  .attr('y',(d,i)=>{
                    return this.height-d*((this.height-100)/sub)-90
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `(坏死${text[j][0]}%)`
                    }
                  })
                  .style('font-size','12px');
                tSpan.append('tspan').attr('x',(d,i)=>{
                    return (j+0.5)*((this.width-130)/n)+50
                  })
                  .attr('y',(d,i)=>{
                    return this.height-d*((this.height-100)/sub)-60
                  })
                  .text((d,i)=>{
                    if(j==i){
                      return `${data[i]}`
                    }
                  })
                  .style('font-size','12px');
              }
          }else{
            if(name=='面积'){
              g.selectAll('text')
              .data(data)
              .enter()
              .append('text')
              .attr('class','targetText')
              .attr('x',(d,i)=>{
                return (i+0.5)*((this.width-130)/n)+50
              })
              .attr('y',(d,i)=>{
                return this.height-d*((this.height-100)/sub)-60
              });
              g.selectAll('text').text((d,i)=>{
                return `${text[i]}cm²`
              })
            }else{
              g.selectAll('text')
                .data(data)
                .enter()
                .append('text')
                .attr('class','targetText')
                .attr('x',(d,i)=>{
                  return (i+0.5)*((this.width-130)/n)+50
                })
                .attr('y',(d,i)=>{
                  return this.height-d*((this.height-100)/sub)-60
                });
                g.selectAll('text').text((d,i)=>{
                  return `${text[i]}`
                })
            }
          }
        }else{
          g.selectAll('text')
            .data(data)
            .enter()
            .append('text')
            .attr('class','targetText')
            .attr('x',(d,i)=>{
              return (i+0.5)*((this.width-130)/n)+50
            })
            .attr('y',(d,i)=>{
              return this.height-d*((this.height-100)/sub)-60
            });
          g.selectAll('.targetText').text((d,i)=>{
            return data[i]
          })
        }
        for(var i=0;i<this.pointX.length;i++){
          this.point.push({'x':this.pointX[i].x,
                  'y':this.pointY[i].y});
          this.pointXu.push([
            [{
            'x':this.pointX[i].x,
            'y':this.pointY[i].y
          },
          {
            'x':50,
            'y':this.pointY[i].y
          }],[
          {
            'x':this.pointX[i].x,
            'y':this.pointY[i].y
          },
          {
            'x':this.pointX[i].x,
            'y':this.height-50
          }
          ]])

        }
        // 画路径
        g.append('path')
        .attr('d',line(this.point))
        .attr('stroke', this.color)
        .attr('stroke-width', 5)
        .attr("fill","none");
        for(var i=0;i<this.pointXu.length;i++){
          g.append('path')
            .attr('d',line(this.pointXu[i][0]))
            .attr('stroke', '#000')
            .attr('stroke-width', 2)
            //虚线
            .attr('stroke-dasharray',"4,4")
            .attr("fill","none");
          g.append('path')
            .attr('d',line(this.pointXu[i][1]))
            .attr('stroke', '#000')
            .attr('stroke-width', 2)
            //虚线
            .attr('stroke-dasharray',"4,4")
            .attr("fill","none");
        };
      }
    },
    tabClick(){
      this.foo=true;
      this.padun=0;
      this.getAllChange(this.typeList[Number(this.activeName1)].woundId);
      this.allBGC='#be0000';
      this.allColor='#fff';
      this.areasBGC='#fff';
      this.areasColor='#68c847';
      this.seepageBGC='#fff';
      this.seepageColor='#2e96e6';
      this.typeBGC='#fff';
      this.typeColor='#b45fa6';
      this.painBGC='#fff';
      this.painColor='#c45a11';
      this.color='#be0000';
    },
    getAllChange(id){
      this.loading=true;
      this.API.get('/api/wound/record/listChange',{'woundId':id,'pn':this.pn})
      .then(res=>{
        if(res.code==0){
          res.data.forEach((val,index)=>{
            this.$set(this.Size,index,res.data[index].pages)
          });
          this.changeData=res.data;
          this.getCanvasData();
        if(this.changeData.length>=2){
          this.show3=true;
        }else{
          this.show3=false;
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
    },
    getCanvasData(){
      this.totalScore=[];
      this.areaScore=[];
      this.area=[];
      this.penetrationQuantityScore=[];
      this.penetrationQuantity=[];
      this.woundScore=[];
      this.painLevel=[];
      this.createTime=[];
      this.allWoundInfo=[];
      if(this.changeData.length>=1){
        this.select=this.changeData[this.padun].conversion;
        for(let i=0;i<this.changeData[this.padun].changeResultList.length;i++){
          this.totalScore.push(this.changeData[this.padun].changeResultList[i].totalScore);
          this.areaScore.push(this.changeData[this.padun].changeResultList[i].areaScore);
          this.penetrationQuantityScore.push(this.changeData[this.padun].changeResultList[i].penetrationQuantityScore);
          this.woundScore.push(this.changeData[this.padun].changeResultList[i].woundScore);
          this.painLevel.push(this.changeData[this.padun].changeResultList[i].painLevel);
          this.createTime.push(this.changeData[this.padun].changeResultList[i].createTime);
          this.area.push(this.changeData[this.padun].changeResultList[i].area);
          this.penetrationQuantity.push(this.changeData[this.padun].changeResultList[i].penetrationQuantity);
          this.allWoundInfo[i]=[];
          this.allWoundInfo[i].push(`${this.changeData[this.padun].changeResultList[i].black}`,
                      `${this.changeData[this.padun].changeResultList[i].yellow}`,
                      `${this.changeData[this.padun].changeResultList[i].red}`,
                      `${this.changeData[this.padun].changeResultList[i].pink}`);
        };
      };
      this.len=this.createTime.length;
      if(this.typeList[Number(this.activeName1)].secondWoundType==19){
        this.num=1;
        if(this.foo){
          this.buttunName=1;
        }
        if(this.buttunName==1){
          this.viewAll();
        }else if(this.buttunName==2){
          this.viewAreas();
        }else if(this.buttunName==3){
          this.viewSeepage()
        }else if(this.buttunName==4){
          this.viewType();
        }else if(this.buttunName==5){
          this.viewPain()
        }
      }else{
        this.num=0;
        if(this.foo){
          this.buttunName=2;
        }
        if(this.buttunName==2){
          this.viewAreas();
        }else if(this.buttunName==3){
          this.viewSeepage()
        }else if(this.buttunName==4){
          this.viewType();
        }else if(this.buttunName==5){
          this.viewPain()
        }
      }
    },
    getInfo(){
      this.loading=true;
      this.API.get('/api/patient/info/get',{'cardId':this.$store.state.cardId})
      .then((res)=>{
        if(res.code==0){
          this.sickData=res.data;
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
    }
  },
  created(){
    this.sickName=this.$route.params.name;
    this.path=this.$route.params.path;
    this.old=this.$route.params.old;
    this.typeList=this.$store.state.history;
    if(this.typeList.length>0){
      this.skSelect=this.typeList[0].woundId;
      this.getImageList();
    }

  }
}
</script>

<style>
#sickWound{
  height: 100%;
  overflow: hidden;
}
#sickWound .swiperImg img{
  width: 50%;
}
#sickWound .swiper-slide{
  width:auto;
  text-align: center;
}
#sickWound #show1{
  overflow: hidden;
}
#sickWound h1{
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: relative;
}
#sickWound .content{
  height: calc(100% - 181px);
  overflow-y: auto;
}
#sickWound .left{
   justify-content:flex-start;
}
#sickWound .center{
  width:100%;
}
#sickWound .colFlex{
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 15px;
  font-size: 20px;
  border-bottom:6px solid #efefef
}
#sickWound .row{
  border-bottom:1px solid #ddd;
}
#sickWound .colLeft{
  padding: 10px 15px;
  border-right: 1px solid #ddd;
}
#sickWound .colRight{
  padding: 10px 15px;
}
#sickWound .colLeft span,.colRight span{
  display: block;
  text-align: left;
  padding-bottom: 10px;
}
#sickWound .colRight img{
  box-sizing: border-box;
  padding: 0 8px;
}
#sickWound .textIndet{
  text-indent: 10px;
}
#sickWound .colLeftImg{
  width:100%;
}
#sickWound .colRightImg{
  width:50%;
}
#sickWound .titleList{
  text-align: left;
  border-bottom: 2px solid #409EFF;
}
#sickWound .titleButton{
  border: 0;
  /* background-color: rgb(166,166,166); */
  border-radius: 7px 7px 0 0;
  color: #fff;
  margin-top: 10px;
}
#sickWound .show{
  text-align: left;
}
#sickWound .skSelect{
  max-width: 200px;
  min-width: 100px;
  width: 30%;
}
#sickWound .skSelect .el-input__inner{
  border: 0;
  background-color: #409EFF;
  color: #fff;
}
#sickWound .skSelect .el-select__caret{
  color: #fff;
}
#sickWound .show .top{
  display: flex;
  margin: 10px;
}
#sickWound .skTabs{
  padding-left: 20px;
  overflow-x: auto;
  overflow-y: hidden;
}
#sickWound .skTabs .el-tabs__item{
  height: 28px;
  line-height: 28px;
}
#sickWound .main .years{
  width: 100%;
  padding: 0 40px;
  box-sizing: border-box;
}
#sickWound .main .years img{
  width: 100%;
  height:100%;
}
#sickWound .table{
  padding: 10px 0;
  border-bottom:1px solid #ddd;
}
#sickWound .diaButton{
  color: #fff;
  border: 0;
}


/* 画图 */
#sickWound .btnAll{
  border-color:#be0000;
}
#sickWound .btnAreas{
  border-color:#68c847;
}
#sickWound .btnSeepage{
  border-color:#2e96e6;
}
#sickWound .btnType{
  border-color:#b45fa6;
}
#sickWound .btnPain{
  border-color:#c45a11;
}
#sickWound .btnSet{
  position: absolute;
  top:140px;
  right: 20px;
}
#sickWound .btnDiv{
  display: block;
  width:100%;
  height:30px;
  margin: 10px 0;
  text-align: right;
}
#sickWound .btnLi{
  float:right;
}

#sickWound .paddingLR30{
  padding-left: 20px;
  padding-right:20px;
  box-sizing: border-box;
}
#sickWound .paddingBottom50{
  padding-bottom: 50px;
}
#sickWound table{
  width:100%;
  text-align: center;
  border-color:#ccc;
  border-collapse: collapse;
  margin-top:20px;
  line-height: 30px;
}
#sickWound .trStyle{
  background-color:#e9e9e9;
  opacity: 0.8;
}
#sickWound .trHeight{
  line-height: 20px;
}
#sickWound .thWeight{
  font-weight: 400;
}
#sickWound .thWeight span{
  font-size: 12px;
}
#sickWound .el-date-editor.el-input, .el-date-editor.el-input__inner{
  width: 100%;
}
#sickWound .jieguo{
  display: flex;
  justify-content: start;
}
#sickWound .jieguo .el-input{
  display: inline-block;
}
#sickWound .jieguo .el-input__inner{
  width:140px;
  border:0;
  border-bottom: 1px solid #ccc;
  text-align: center;
  border-radius: 0;
  height: 30px;
}
#sickWound #show1 .el-input__inner{
  border: 0;
  background-color: #2eb4e7;
  color: #fff;
  padding: 0;
  text-align: center
}
#sickWound .updateTime{
  color:red;
  padding-left: 10px;
}
#sickWound #show1 .el-tabs__header{
  margin-bottom:0;
}
</style>
