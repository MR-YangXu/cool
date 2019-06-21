<template>
  <div id="change" v-loading="loading">
    <div class="container1">
      <h1>患者：{{sickName}}</h1>
      <div class="buttonSite">
        <el-button size="mini" type="primary" class="buttonBGC1" @click="clickButton(1)">愈合变化一览</el-button>
        <el-button size="mini" type="primary" class="buttonBGC1" @click="clickButton(2)">转归与患者去向提交归档</el-button>
      </div>
      <div class="tabSite">
        <el-tabs v-model="activeName" @tab-click="tabClick">
          <el-tab-pane v-for="(item,index) in allSicks" :key="item.id" :label="item.woundNameSimple" :name="String(index)"></el-tab-pane>
        </el-tabs>
      </div>
      <div id="show1" @touchstart="getTouchX"  @touchend="autoRefreshData" v-show="show1">
        <div class="btnSet">
          <div class="btnDiv">
            <el-button type="primary" class="btnLi" @click="linkTo" size="mini">查看图片记录</el-button>
          </div>
          <div class="btnDiv" v-if="show3">
            <el-select v-model="woundAllId" @change="targetSelect" size="small">
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
            <el-button v-if="allSicks[Number(activeName)].secondWoundType==19" class="btnLi btnAll" @click="viewAll" size="mini" :style="{backgroundColor:allBGC,color:allColor}"> 总体 </el-button>
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
      <div id="show2" v-show="show2">
        <div v-show="allSicks[Number(activeName)].infoList.length>=2" style="padding:0 10px;text-align:left;box-sizing:border-box;">
          <el-button :style="{backgroundColor: Color[index]}"  @click="thirdClick(index)" v-for="(item,index) in allSicks[Number(activeName)].infoList" :key="index" size="mini" class="buttonBGC2">伤口{{index+1}}</el-button>
        </div>
        <p style="margin:0;color:red;text-align:left;padding-left:10px;">注：结束伤口治疗时，请进行下列记录并提交归档。</p>
        <h6>转归情况</h6>
        <el-row style="text-align:left">
          <el-col :span="5" :offset="1" v-for="item in changeLeavel" :key="item.value">
            <el-radio-group v-model="situation">
              <el-radio :label="item.value">{{item.label}}</el-radio>
            </el-radio-group>
          </el-col>
        </el-row>
        <h6 v-if="situation>1">患者去向</h6>
        <el-row  v-if="situation>1" style="text-align:left">
          <el-col style="line-height:30px;" :span="23" :offset="1" v-for="item in whereAbouts" :key="item.id">
            <el-radio-group v-model="about" @change="radioChange">
              <el-radio :label="item.id">{{item.value}}</el-radio>
            </el-radio-group>
            <el-input  @focus="hideFoot" @blur="showFoot" class="elseInput1" placeholder="请输入转诊部门" v-if="about==whereAboutsId&&item.id==about" v-model="referralName"></el-input>
            <el-row v-if="about!=whereAboutsId&&item.id==about">
              <el-col :span="22" :offset="2" v-for="items in medicine" :key="items.value">
                <el-radio-group v-model="NOY">
                  <el-radio :label="items.value">{{items.label}}</el-radio>
                </el-radio-group>
              </el-col>
            </el-row>
            <el-row v-if="about!=whereAboutsId&&item.id==about&&NOY==1">
              <p style="color:red">请记录所带敷料</p>
              <el-col :span="11" :offset="1" v-for="(item1,index1) in allConstList" :key="index1">
                <el-checkbox-group v-model="outDressingId" class="checkboxAdd" disabled>
                  <el-checkbox :label="item1.id" class="textBreak">{{item1.value}}</el-checkbox>
                  <span v-if="item1.value!='其他'" class="addSpanStyle" @click="selectDressimgType(index1,item1.id)"><icon class="icon" name="add1" width="20" height="20"></icon></span>
                  <el-input @focus="hideFoot" class="elseInput" v-if="item1.value=='其他'" v-model="dressingOther" @blur="elseInputBlur(item1.id)"></el-input>
                </el-checkbox-group>
                <p v-if="outDressingId.includes(item1.id)" style="padding-left:30px;margin:0;color:#2e96e6">{{dressingTypeName[item1.id]}}</p>
              </el-col>
            </el-row>

          </el-col>
        </el-row>
        <h6>患者病历完整度</h6>
        <el-row style="text-align:left">
          <el-col :span="11" :offset="1" v-for="item in IntegrityRungs" :key="item.value">
            <el-radio-group v-model="rungs">
              <el-radio :label="item.value">{{item.label}}</el-radio>
            </el-radio-group>
          </el-col>
        </el-row>
        <h6>愈合评价备注</h6>
        <el-row>
          <el-col :span='22' :offset="1">
            <el-input v-model="healRemark" class="remark" @focus="hideFoot" @blur="showFoot" placeholder="请输入备注"></el-input>
          </el-col>
        </el-row>
        <h6>签名</h6>
        <div class="radio writeName">
          <span>护士：<el-button v-if="btnShow" type="text" @click="handleSignature" class="radioBtn">点击签名</el-button><img id='name1' @click="handleSignature" :src="nurseName" v-if="imgShow"></span>
          <el-button :loading='loading' size="mini" @click="submit" type="primary" style="width:260px;">提交并归档</el-button>
        </div>
        <div id="canvasBox"  v-show="canvasShow">
          <canvas id="canvas" width=0 height=0 style="border:1px solid #828282;background-color:#fff;"></canvas>
          <button class="canvasBtn" @click="clearCanvas">清屏</button><button class="canvasBtn" @click="saveCanvas">保存</button>
        </div>
      </div>
    </div>
    <Foot v-show="!isFocus" :index="index" id="Foot" :save="save"></Foot>
    <el-dialog title="敷料类型" :visible.sync="dialogVisible" width="50%" center :show-close="false"
          :close-on-click-modal="false"
          :close-on-press-escape="false">
      <div id="tent">
        <el-radio  v-model="dressingIds" class="elseCheck"  @change="changeDressingType(Item.name)" v-for="(Item,Index) in dressingType" :key="Index" :label="Item.id">{{Item.name}}</el-radio>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelElseCheck">取 消</el-button>
        <el-button type="primary" @click="showElseCheck">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
// import * as d3 from 'd3'
import Foot from '../../components/footer'
export default {
  name:'change',
  components:{Foot},
  data(){
    return{
      isFocus: false,
      save:false,
      foo:true,
      buttunName:1,
      Size:[],
      X:0,
      X1:0,
      pn:1,
      Color:[],
      loading:false,
      healRemark:'',
      woundAllId:0,
      loading:false,
      indeX:0,
      nurseName:'',
      canvasShow:false,
      imgShow:false,
      btnShow:true,
      dressingType:[],
      dressingId:[],
      dressingIds:null,
      typeName:null,
      falseFatherID:null,
      dialogVisible:false,
      allConstList:[],
      dressingFatherID:null,
      dressingTypeName:[],
      dressingOther:'',
      outDressingId:[],
      NOY:'',
      medicine:[
        {
          value:1,
          label:'带敷料'
        },
        {
          value:0,
          label:'不带敷料'
        }
      ],
      referralName:'',
      rungs:'',
      IntegrityRungs:[
        {
          value:1,
          label:'完整'
        },
        {
          value:0,
          label:'不完整'
        },
      ],
      about:'',
      whereAbouts:[],
      whereAboutsId:'',
      situation:'',
      changeLeavel:[
        {
          value:1,
          label:'愈合'
        },
        {
          value:2,
          label:'好转'
        },
        {
          value:3,
          label:'无变化'
        },
        {
          value:4,
          label:'恶化'
        },
      ],
      woundShape:[],
      activeName:'0',
      show1:true,
      show2:false,
      show3:false,
      num:1,
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
      index:'3',
      sickName:'',
      point:[],
      pointXu:[],
      pointX:[],
      pointY:[],
      color:'#be0000',
      data:[6.1,4,1],
      width:'',
      height:'',
      svg:null,
      select:'1',
      allSicks:[
        {
          infoList:[],
          secondWoundType:''
        }
      ],
      woundId:null,
      changeData:[],
      totalScore:[],
      areaScore:[],
      area:[],
      penetrationQuantityScore:[],
      penetrationQuantity:[],
      woundScore:[],
      painLevel:[],
      createTime:[],
      len:null,
      id:null,
      allWoundInfo:[]
    }
  },
  created(){
    this.sickName=this.$store.state.sickMessage.name;
    this.id=this.$store.state.sickMessage.id;
    this.getInfoList();
    this.getSonConstList('woundShape');
    this.getSonConstList('patientGoing');
    this.getSonConstList('dressingType');
  },
  methods:{
    //获取触摸点的X坐标
    getTouchX(e){
      this.X=e.touches[0].clientX;
    },
    //左右滑动刷新画图数据
    autoRefreshData(e){
      this.X1=e.changedTouches[0].clientX;
      if(this.X1-this.X>=50){
        this.pn++;
        if(this.pn>this.Size[Number(this.woundAllId)]){
          this.pn--;
          this.$message({
            type:'info',
            message:'没有更多数据了',
            duration:1000
          })
        }else{
          this.foo=false;
          this.getAllChange(this.allSicks[Number(this.activeName)].woundId);
        }
        this.X=0;
        this.X1=0;
      }else if(this.X-this.X1>=50){
        this.pn--;
        if(this.pn>0){
          this.foo=false;
          this.getAllChange(this.allSicks[Number(this.activeName)].woundId);
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
    //聚焦让底部栏消失
    hideFoot(){
      this.isFocus = true
      document.getElementsByClassName('container1')[0].style.height='100%'
    },
    //失焦让底部栏出现
    showFoot(){
      this.isFocus = false
      document.getElementsByClassName('container1')[0].style.height='calc(100% - 80px)'
    },
    //获取伤口历史
    thirdClick(index){
      this.indeX=index;
      this.nurseName='';
      this.canvasShow=false;
      this.imgShow=false;
      this.btnShow=true;
      this.dressingType=[];
      this.dressingId=[];
      this.typeName=null;
      this.falseFatherID=null;
      this.dressingTypeName=[];
      this.dressingOther='';
      this.referralName='';
      this.rungs='';
      this.NOY='';
      this.about='';
      this.situation='';
      this.outDressingId=[];
      this.Color.forEach((val,i)=>{
        if(index==i){
          this.Color[i]='#409EFF'
        }else{
          this.Color[i]='rgb(166,166,166)'
        }
      })
    },
    //提交
    submit(){
      if(this.allSicks[Number(this.activeName)].infoList.length>0){
        for(let i=0;i<this.dressingId.length;i++){
          if(typeof(this.dressingId[i])!='number'){
            this.dressingId.splice(i,1);
            i--;
          }
        }
        let data={
          'id':this.allSicks[Number(this.activeName)].infoList[this.indeX].infoId,
          'conversion':this.situation,
          'completeFlag':this.rungs,
          'nurseName':this.nurseName,
          'referralName':this.referralName,
          'patientGoing':this.about,
          'dressingOther':this.dressingOther,
          'dressingId':this.dressingId.join(','),
          'healRemark':this.healRemark
        };
        this.loading=true;
        this.API.post('/api/wound/record/conversion',data)
        .then(res=>{
          if(res.code==0){
            this.$message({
              type:'success',
              message:res.message,
              duration:1000
            });
            this.nurseName='';
            this.canvasShow=false;
            this.imgShow=false;
            this.btnShow=true;
            this.dressingType=[];
            this.dressingId=[];
            this.dressingIds=null;
            this.typeName=null;
            this.falseFatherID=null;
            this.dressingTypeName=[];
            this.dressingOther='';
            this.referralName='';
            this.rungs='';
            this.NOY='';
            this.about='';
            this.situation='';
            this.outDressingId=[];
          }else{
            this.$message({
              type:'info',
              message:res.message,
              duration:1000
            })
          }
          })
        .catch(err=>{
          this.$message({
            type:'error',
            message:err.message,
            duration:1000
          })
        })
        .finally(()=>{
          this.loading=false
        })
      }else{
        this.$message({
          type:'info',
          message:'请先记录伤口内容',
          duration:1000
        })
      }

    },
    //保存签名
    saveCanvas(){
      this.btnShow=false;
      this.imgShow=true;
      var c=document.getElementById('canvas');
      this.nurseName=c.toDataURL();
      this.canvasShow=false;
    },
    //签名清屏
    clearCanvas(){
      var c=document.getElementById('canvas');
      var ctx=c.getContext('2d');
      ctx.clearRect(0,0,canvas.width,canvas.height);
    },
    //点击签名
    handleSignature(){
      this.canvasShow=true;
      var cBox=document.getElementById('canvasBox');
      var w=document.body.clientWidth;
      var h=document.body.clientHeight;
      cBox.style.bottom=0+'px';
      var c=document.getElementById('canvas');
      c.width=w-20;
      c.height=h-350;
      c.addEventListener('touchstart', this.start,false);
      c.addEventListener('touchmove', this.move,false);
    },
    //开始签名
    start(e){
        var e = event || window.event;
        var h=document.body.clientHeight;
        this.point.X=e.touches[0].clientX;
        this.point.Y=e.touches[0].clientY-(h/2-80-50-77);
        var c=document.getElementById('canvas');
        var ctx=c.getContext('2d');
        ctx.beginPath();
        ctx.moveTo(this.point.X,this.point.Y);
    },
    //签名中
    move(e){
      var e= event || window.event;
      var h=document.body.clientHeight;
       e.preventDefault();//阻止默认事件
      var Point={};
      Point.X=e.changedTouches[0].clientX;
      Point.Y=e.changedTouches[0].clientY-(h/2-80-50-77);
      var c=document.getElementById('canvas');
      var ctx=c.getContext('2d');
      ctx.lineTo(Point.X,Point.Y);
      ctx.stroke();
      ctx.lineWidth = 10;     // 直线宽度
      ctx.strokeStyle = 'black';  // 路径的颜色
      ctx.lineCap = 'round';    // 直线首尾端圆滑
      ctx.lineJoin = 'round';   // 当两条线条交汇时，创建圆形边角
      ctx.shadowBlur = 1;     // 边缘模糊，防止直线边缘出现锯齿
      ctx.shadowColor = 'black';  // 边缘颜色
    },
    // 选择辅料子类型
    changeDressingType(name){
      this.typeName=name;
    },
    //确定敷料类型
    showElseCheck(){
      this.dialogVisible = false;
      this.dressingFatherID=this.falseFatherID;
      // this.dressingTypeName=this.typeName;
      this.$set(this.dressingTypeName,this.falseFatherID,this.typeName)
      this.$set(this.dressingId,this.falseFatherID,this.dressingIds);
      this.dressingIds=null;
      this.outDressingId.push(this.dressingFatherID)
      // this.dressingOther='';
    },
    //取消敷料类型选择
    cancelElseCheck(){
      this.dialogVisible = false;
      this.checkList=null;
    },
    //其他敷料输入
    elseInputBlur(ID){
      if(this.dressingOther){
        this.outDressingId.push(ID)
        this.API.get('/api/pub/dressing/get',{'typeId':ID})
        .then(res=>{
          this.$set(this.dressingId,ID,res.data[0].id);
        })
      }else{
        this.dressingId.splice(ID,1);
        this.outDressingId.forEach((val,index)=>{
          if(val==ID){
            this.outDressingId.splice(index,1)
          }
        })
      }
      document.getElementById('Foot').style.display='block';
      document.getElementsByClassName('container1')[0].style.height='calc(100% - 80px)'
    },
    //获取辅料的子类
    selectDressimgType(index,id){
      this.falseFatherID=id;
      this.loading=true;
      this.API.get('/api/pub/dressing/get',{'typeId':id})
      .then(res=>{
        if(res.code==0){
          this.dressingType=res.data;
          this.dialogVisible = true;
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
    //患者取消改选
    radioChange(){
      this.dressingType=[];
      this.dressingId=[];
      this.dressingIds=null;
      this.typeName=null;
      this.falseFatherID=null;
      this.dressingTypeName=[];
      this.dressingOther='';
      this.referralName='';
      this.NOY='';
      this.outDressingId=[];
    },
    //获取子常量列表
    getSonConstList(type){
      // if(type="woundShape")
      this.API.get('/api/pub/const/get',{'type':type})
      .then(res=>{
        if(res.code==0){
          if(type=="woundShape"){
            this.woundShape=res.data;
          }else if(type=="patientGoing"){
            this.whereAbouts=res.data;
            this.whereAboutsId=this.whereAbouts[0].id;
          }else if(type=="dressingType"){
            this.allConstList=res.data;
          }

        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          })
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
    //标签页切换
    tabClick(){
      this.pn=1;
      this.woundAllId=0;
      if(this.show1){
        this.foo=true;
        this.getAllChange(this.allSicks[Number(this.activeName)].woundId);
      }else{
        this.indeX=0;
        if(this.allSicks[Number(this.activeName)].infoList.length>=2){
          this.allSicks[Number(this.activeName)].infoList.forEach((val,index)=>{
            this.$set(this.Color,index,'rgb(166,166,166)')
          });
          this.Color[0]='#409EFF';
        };
      }
      this.nurseName='';
      this.healRemark='';
      this.canvasShow=false;
      this.imgShow=false;
      this.btnShow=true;
      this.dressingType=[];
      this.dressingId=[];
      this.dressingIds=null;
      this.typeName=null;
      this.falseFatherID=null;
      this.dressingTypeName=[];
      this.dressingOther='';
      this.referralName='';
      this.rungs='';
      this.NOY='';
      this.about='';
      this.situation='';
      this.outDressingId=[];
      this.num=1;
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
    //顶部标签按钮切换
    clickButton(index){
      if(index===1){
        this.show1=true;
        this.show2=false;
        document.getElementsByClassName('buttonBGC1')[1].style.backgroundColor='rgb(166,166,166)';
        document.getElementsByClassName('buttonBGC1')[0].style.backgroundColor='#409EFF';
        this.getAllChange(this.allSicks[Number(this.activeName)].woundId);
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
      }else if(index===2){
        d3.select('#svgarea').remove();
        this.show1=false;
        this.show2=true;
        this.indeX=0;
        document.getElementsByClassName('buttonBGC1')[0].style.backgroundColor='rgb(166,166,166)';
        document.getElementsByClassName('buttonBGC1')[1].style.backgroundColor='#409EFF';
        if(this.allSicks[Number(this.activeName)].infoList.length>0){
          for(let i=0;i<this.allSicks[Number(this.activeName)].infoList.length;i++){
            this.$set(this.Color,i,'rgb(166,166,166)')
          };
          this.Color[0]='#409EFF'
        }
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
      d3.select('#svgarea').remove();
      this.height=window.screen.height-216;
      this.width=window.screen.width;
      this.svg=d3.select('#show1')
        .append('svg');
      this.svg.attr('width',this.width)
          .attr('height',this.height)
          .attr('id','svgarea');
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
        .attr('class','gs')
        .attr('transform',"translate(0,"+(this.height-50)+")")
        .attr('stroke-width','1')
        .call(axisX)
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
      if(this.allSicks[Number(this.activeName)].secondWoundType==19){
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
      .y((d)=>{
          return d.y
        }
      );
      if(this.allSicks[Number(this.activeName)].secondWoundType!=19&&name=='创面组织成分'){
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
                color[sum]='red'
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
      };
    },
    linkTo(){
      if(this.$store.state.woundInfoHistory.length>0){
        this.$store.commit('setCardID1',this.$store.state.ceadID);
        this.$store.commit('historySet',this.$store.state.woundInfoHistory)
        this.$router.push({
          name:'sickWound',
          params:{
            path:'/change',
            name:this.$store.state.sickMessage.name,
            old:true
          }
        })
      }else{
        this.loading=true;
        this.API.get('/api/patient/info/getWoundList',{'patientId':this.allSicks[0].woundId})
        .then(res=>{
          if(res.code==0){
            this.$store.commit('setCardID1',this.$store.state.ceadID);
            this.$store.commit('historySet',res.data)
            this.$router.push({
              name:'sickWound',
              params:{
                path:'/change',
                name:this.$store.state.sickMessage.name
              }
            })
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
    getAllChange(id){
      this.loading=true;
      this.API.get('/api/wound/record/listChange',{'woundId':id,'pn':this.pn})
      .then(res=>{
        if(res.code==0){
          res.data.forEach((val,index)=>{
            this.$set(this.Size,index,res.data[index].pages)
          });
          this.changeData=res.data;
          if(this.changeData.length>=2){
            this.show3=true;
          }else{
            this.show3=false;
          };
          this.getCanvasData();
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
    //获取绘图数据
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
        this.select=this.changeData[0].conversion;
        for(let i=0;i<this.changeData[0].changeResultList.length;i++){
          this.totalScore.push(this.changeData[0].changeResultList[i].totalScore);
          this.areaScore.push(this.changeData[0].changeResultList[i].areaScore);
          this.penetrationQuantityScore.push(this.changeData[0].changeResultList[i].penetrationQuantityScore);
          this.woundScore.push(this.changeData[0].changeResultList[i].woundScore);
          this.painLevel.push(this.changeData[0].changeResultList[i].painLevel);
          this.createTime.push(this.changeData[0].changeResultList[i].createTime);
          this.area.push(this.changeData[0].changeResultList[i].area);
          this.penetrationQuantity.push(this.changeData[0].changeResultList[i].penetrationQuantity);
          this.allWoundInfo[i]=[];
          this.allWoundInfo[i].push(`${this.changeData[0].changeResultList[i].black}`,
                      `${this.changeData[0].changeResultList[i].yellow}`,
                      `${this.changeData[0].changeResultList[i].red}`,
                      `${this.changeData[0].changeResultList[i].pink}`);
        };
      };
      this.len=this.createTime.length;
      if(this.allSicks[Number(this.activeName)].secondWoundType==19){
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
          this.buttunName=2
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
    targetSelect(val){
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
        this.select=this.changeData[this.woundAllId].conversion;
        for(let i=0;i<this.changeData[this.woundAllId].changeResultList.length;i++){
          this.totalScore.push(this.changeData[this.woundAllId].changeResultList[i].totalScore);
          this.areaScore.push(this.changeData[this.woundAllId].changeResultList[i].areaScore);
          this.penetrationQuantityScore.push(this.changeData[this.woundAllId].changeResultList[i].penetrationQuantityScore);
          this.woundScore.push(this.changeData[this.woundAllId].changeResultList[i].woundScore);
          this.painLevel.push(this.changeData[this.woundAllId].changeResultList[i].painLevel);
          this.createTime.push(this.changeData[this.woundAllId].changeResultList[i].createTime);
          this.area.push(this.changeData[this.woundAllId].changeResultList[i].area);
          this.penetrationQuantity.push(this.changeData[this.woundAllId].changeResultList[i].penetrationQuantity);
          this.allWoundInfo[i]=[];
          this.allWoundInfo[i].push(`${this.changeData[this.woundAllId].changeResultList[i].black}`,
                      `${this.changeData[this.woundAllId].changeResultList[i].yellow}`,
                      `${this.changeData[this.woundAllId].changeResultList[i].red}`,
                      `${this.changeData[this.woundAllId].changeResultList[i].pink}`);
        };
      };
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
      this.len=this.createTime.length;
      if(this.allSicks[Number(this.activeName)].secondWoundType==19){
        this.buttunName=1;
        this.color='#be0000';
        this.num=1;
        this.canvas('愈合分数',this.totalScore,this.createTime,this.len,this.num);
      }else{
        this.buttunName=2;
        this.num=0;
        this.color='#68c847';
        this.canvas('面积',this.areaScore,this.createTime,this.len,this.num,this.area);
        this.areasBGC='#68c847';
        this.areasColor='#fff';
      }
    },
    getInfoList(){
      this.loading=true;
      this.API.get('/api/patient/info/getWoundList',{'patientId':this.id})
      .then((res)=>{
        if(res.code==0){
          this.$store.commit('setHistory',res.data);

          if(res.data.length>0){
             this.allSicks=res.data;
            this.allSicks[Number(this.activeName)].infoList.forEach((val,index)=>{
              if(this.index==0){
                this.$set(this.Color,index,'#409EFF')
              }else{
                this.$set(this.Color,index,'rgb(166,166,166)')
              }

            })
            this.activeName='0';
            this.woundId=this.allSicks[0].woundId;
            this.getAllChange(this.woundId);
            this.allBGC='#be0000';
            this.allColor='#fff';
          }else if(res.data.length==0){
            this.$message({
              type:'info',
              message:'请先记录伤口',
              duration:1000
            });
          };
          this.loading=false;
        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          });
          this.loading=false;
        }
      })
      .catch((err)=>{
        this.$message({
          type:'error',
          message:err.message,
          duration:1000
        });
        this.loading=false;
      })
    },
  },
}
</script>

<style>
@import url('./change.css');
</style>


