<template>
  <div id="chulifangshi" v-loading="fullscreenLoading">
    <div id="scrolltop">
      <h1>患者:{{sickData.name}}</h1>
      <div class="woundNum">
        <template v-for="(items,index) in woundInfoHistory">
          <el-button class="buttonBGC1" :key="index" size="mini" type="primary" @click="chooseSick(index)">
            {{items.woundName}}
            <!-- <i class="el-icon-error" @click="handleDeleteSk(items,index)"></i> -->
          </el-button>
        </template>
        <el-button size="mini" type="text" @click="addElseWound"><i class="el-icon-circle-plus"></i>新增其他处伤口</el-button>
      </div>
      <el-row style="height: calc(100% - 101px)">
        <el-tabs v-model="activeName" :before-leave="handleClick">
          <el-tab-pane label="伤口类型录入" name="first">
            <div class="tabShow radioTab">
              <div class="paddingLR30">
                <el-radio-group style="width:100%"  v-model="woundInfoHistory[itemIndex].firstWoundType">
                  <template>
                    <div v-for="(item,index) in woundGather" :key="index">
                      <el-row class="paddingTB10">
                        <el-radio :label=index+1>{{woundGather[index].name}}</el-radio>
                      </el-row>
                      <el-row v-show="woundInfoHistory[itemIndex].firstWoundType == index+1" class="paddingTB10 paddingLR30 ckeckListStyle">
                        <el-col :span="12" v-for="(it,ind) in woundGather[index].children" :key="ind" class="lineHeight30">
                          <el-checkbox-group v-model="woundTypeValue" class="flexWound">
                            <div class="checkboxAdd">
                              <el-checkbox :label="it.id" class="textBreak" @change="cleanTypeName(it)">{{it.name}}</el-checkbox>
                            </div>
                            <el-select class="INPUTS1" :placeholder="placeHolderName[it.id]" :disabled="extraDis[it.id]" v-model="extraSelect[it.id]" v-if="it.woundLevel.length>0">
                              <el-option v-for="(items,indexs) in it.woundLevel" :key="indexs" :label="items.value" :value="items.id"></el-option>
                            </el-select>
                          </el-checkbox-group>
                          <el-radio-group v-model="woundInfoHistory[itemIndex].thirdWoundType" v-if="it.children&&it.id==woundTypeValue[0]&&pShow==false" @change="radioChange(index,ind)">
                            <el-radio class="radioSelect" v-for="(itemChild ,indexChild) in it.children" :key="indexChild" :label="itemChild.id">
                              {{itemChild.name}}
                              <span v-if="itemChild.name=='其他'" class="elseInput1">
                                <el-input  @focus="hideFoot" ref="content" @blur="blurInput(index,ind)" v-model='elseWord'></el-input>
                              </span>
                            </el-radio>
                          </el-radio-group>
                          <p @click="selectThirdChild" style="padding-left:30px;line-height:30px;height:30px;margin:0px;font-size:14px;color:#2e96e6" v-if="it.children&&it.id==woundTypeValue[0]&&pShow">{{woundTypeName}}</p>
                        </el-col>
                      </el-row>
                    </div>
                  </template>
                </el-radio-group>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="伤口图像与信息录入" name="second">
            <div class="tabShow" ref="tabSecond">
              <div class="woundNum" style="padding-bottom:5px;position:fixed;z-index:33;background-color:#fff;" v-if="woundInfoImg.woundInfoList.length >= 2||woundInfoImg.woundShape==51">
                <el-button size="mini" v-if="woundInfoImg.woundInfoList.length >= 2" class="buttonBGC" v-for="(item,index) in woundInfoImg.woundInfoList" :key="index" @click="switchWound(index)">伤口{{index+1}}</el-button>
                <span v-if="woundInfoImg.woundShape==51" style="margin-left:10px"><el-button size="mini" type="primary"  @click="addWound">添加伤口</el-button></span>
              </div>
              <div v-if="woundInfoImg.woundInfoList.length >= 2" style="margin-top:40px;"></div>
              <div>
                <h6 style="margin-top:0;">伤口拍摄</h6>
                <el-row>
                  <el-col :span="6" v-for="item in photoName" :key='item.value'>
                    <div style="margin-bottom:50px;position:relative;">
                      <div class="getPhoto"  @click="popover(item.value)" >
                        <div class='putPhoto' v-if="!woundInfoImg.photo[item.value]">
                          <icon name="add" width="25" height="25"></icon>
                          <p v-html="item.name"></p>
                        </div>
                        <input :id="'camera'+item.value" class="cameraStyle" type="file" accept="image/*" capture="camera" @click="cameraClick" @change="cameraChange">
                        <!-- <img :src="woundInfoImg.photo[item.value]" alt="" v-if="woundInfoImg.photo[item.value]" style="width:100%;height:100%;" @click="handleViewImg"> -->
                      </div>
                      <img :src="woundInfoImg.photo[item.value]" alt="" v-if="woundInfoImg.photo[item.value]" style="width:100%;height:100%;position:absolute;top:0;left:0;" @click="handleViewImg(item.value,woundInfoImg.photo[item.value])">
                      <!-- <el-button type="primary"  size="mini" @click="handleLookIMG(woundInfoImg.photo[item.value])" v-if="woundInfoImg.photo[item.value]"
                      style="position:absolute;top:105px;width:50%;left:25%;">查看</el-button> -->
                    </div>
                  </el-col>
                </el-row>
                <el-row class="paddingTop20">
                  <h6 style="margin-top:0;">伤口部位</h6>
                  <el-col :span="22" :offset="1" class="flexBetwen">
                    <el-form label-width="100px" class="borderBottom" style="margin:0 5px 0 0;width:90%;max-width:210px" >
                      <el-form-item label="" style="margin-bottom:0px;">
                        <el-input  @focus="hideFoot" @blur="showFoot" placeholder="请输入受伤部位" v-model.trim='woundInfoImg.site'  size="mini"></el-input>
                      </el-form-item>
                    </el-form>
                    <div>
                      <button v-if="woundInfoImg.voices" style="padding:7px 15px;border-radius:5px;border:0;background-color:#409EFF;color:#fff;outline:none" @click="startPLay" type="primary"><span class="elSpan"><icon name="message" width="14" height="14"></icon>语音备注播放</span></button>
                    </div>
                    <div style="position:relative;">
                      <button v-if="woundInfoImg.voices" style="padding:7px 15px;border-radius:5px;border:0;background-color:#409EFF;color:#fff;outline:none" @touchstart="startVoice" @touchend="stopVoice"><span class="elSpan"><icon name="import" width="14" height="14"></icon>请按住重新录入</span></button>
                      <button v-if="!woundInfoImg.voices" style="padding:7px 15px;border-radius:5px;border:0;background-color:#409EFF;color:#fff;outline:none" @touchstart="startVoice" @touchend="stopVoice"><span class="elSpan"><icon name="import" width="16" height="16"></icon>请按住说话</span></button>
                    </div>
                  </el-col>
                  <p style="color:#ccc;font-size:12px;float:right;margin:0 25px 0 0;">若无法测量，请按住<br>进行语音录入备注</p>
                </el-row>
                <h6>伤口大小</h6>
                <el-form label-width="82px" label-position="right">
                  <el-row style="display:flex;justify-content:space-around;">
                    <el-col :span="7">
                      <el-form-item label="长    度：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" maxlength="2" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].length" @change="countArea">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <el-col :span="7">
                      <el-form-item label="宽    度：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].width"  @change="countArea">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <el-col :span="7">
                      <el-form-item label="深    度：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].depth" @change="countVolume">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                  </el-row>
                  <el-row style="display:flex;justify-content:space-around;">
                    <el-col :span="7">
                      <el-form-item label="面    积：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].area" @change="countVolume">
                          <template slot="append">cm<sup>2</sup></template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <el-col :span="7">
                      <el-form-item label="体    积：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].volume">
                          <template slot="append">cm<sup>3</sup></template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <el-col :span="7">
                      <el-form-item label="切口总长：">
                        <el-input @focus="hideFoot" @blur="showFoot" type="number" class="inputStyle" size="mini" v-model.number="woundInfoImg.woundInfoList[WI].sutureLength">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                  </el-row>
                  <!-- 潜行/都到 -->
                  <el-row style="display:flex;justify-content:space-around;">
                    <el-col :span="7" v-for="(item ,index ) in woundSize" :key="index" style="">
                      <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].radio" @change="checkData">
                        <el-checkbox :label="index">{{item}}</el-checkbox>
                      </el-checkbox-group>
                    </el-col>
                  </el-row>
                </el-form>
                <el-form inline class="paddingTop20" v-if="qianXing||douDao||louGuan">
                  <el-row v-if="qianXing" style="display:flex;align-items:center">
                    <el-col :span='5' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sneakType">
                        <el-radio :label="0">单点</el-radio>
                      </el-radio-group>
                    </el-col>
                    <el-col :span='11' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sneakType">
                        <el-radio :label="1">扇面</el-radio>
                      </el-radio-group>
                      <el-select v-model="woundInfoImg.woundInfoList[WI].sneakStart" class="width50 INPUTS">
                        <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                      </el-select>
                      <span>点</span>
                      <span>至</span>
                      <el-select v-model="woundInfoImg.woundInfoList[WI].sneakEnd" class="width50 INPUTS">
                        <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                      </el-select>
                      <span>点</span>
                    </el-col>
                    <el-col :span='5' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sneakType">
                        <el-radio :label="2">全周</el-radio>
                      </el-radio-group>
                    </el-col>
                  </el-row>
                  <el-row v-if="qianXing">
                    <el-col :span="20" :offset="1" v-for="(item,index) in woundInfoImg.woundInfoList[WI].sneakList" :key="index">
                      <el-form-item :label="'潜行'+(index+1)">
                        <el-select v-model="item.startPoint" class="width100 INPUTS">
                          <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                        </el-select>
                      </el-form-item><span style="line-height:40px;padding-right:10px;">点</span>
                      <el-form-item label="长度">
                        <el-input @focus="hideFoot" @blur="showFoot" size="mini" v-model="item.length" class="inputStyle width100 INPUTS">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <span @click="addP('1')">
                      <icon name="add" width="30" height="30"></icon>
                    </span>
                  </el-row>
                  <el-row v-if="qianXing">
                    <el-col :span="22" :offset="1">
                      <label>
                        <span style="display:inline-block;width:50px;line-height:40px;">备注：</span>
                        <el-input @focus="hideFoot" @blur="showFoot" v-model="woundInfoImg.woundInfoList[WI].sneakRemark" class="inputStyle" style="width:calc(100% - 50px);float:right"></el-input>
                      </label>
                    </el-col>
                  </el-row>
                  <el-row v-if="douDao" style="display:flex;align-items:center">
                    <el-col :span='5' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sinusType">
                        <el-radio :label="0">单点</el-radio>
                      </el-radio-group>
                    </el-col>
                    <el-col :span='11' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sinusType">
                        <el-radio :label="1">扇面</el-radio>
                      </el-radio-group>
                      <el-select v-model="woundInfoImg.woundInfoList[WI].sinusStart" class="width50 INPUTS">
                        <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                      </el-select>
                      <span>点</span>
                      <span>至</span>
                      <el-select v-model="woundInfoImg.woundInfoList[WI].sinusEnd" class="width50 INPUTS">
                        <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                      </el-select>
                      <span>点</span>
                    </el-col>
                    <el-col :span='5' :offset="1">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].sinusType">
                        <el-radio :label="2">全周</el-radio>
                      </el-radio-group>
                    </el-col>
                  </el-row>
                  <el-row v-if="douDao">
                    <el-col :span="20" :offset="1" v-for="(item,index) in woundInfoImg.woundInfoList[WI].sinusList" :key="index">
                      <el-form-item :label="'窦道'+(index+1)">
                        <el-select v-model="item.startPoint" class="width100 INPUTS">
                          <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                        </el-select>
                        <span style="line-height:40px;padding-right:10px;">点</span>
                      </el-form-item>
                      <el-form-item label="长度">
                        <el-input @focus="hideFoot" @blur="showFoot" size="mini" v-model="item.length" class="inputStyle width100 INPUTS">
                            <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                      </el-col>
                    <span @click="addP('2')">
                      <icon name="add" width="30" height="30"></icon>
                    </span>
                  </el-row>
                  <el-row v-if="douDao">
                    <el-col :span="22" :offset="1">
                      <label>
                        <span style="display:inline-block;width:50px;line-height:40px;">备注：</span>
                        <el-input @focus="hideFoot" @blur="showFoot" v-model="woundInfoImg.woundInfoList[WI].sinusRemark" style="width:calc(100% - 50px);float:right;border-bottom:1px solid #ccc"></el-input>
                      </label>
                    </el-col>
                  </el-row>
                  <el-row v-if="louGuan">
                    <el-col :span="20" :offset="1" v-for="(item,index) in woundInfoImg.woundInfoList[WI].fistulaList" :key="index">
                      <el-form-item :label="'瘘管'+(index+1)">
                        <el-select v-model="item.startPoint" class="width100 INPUTS">
                          <el-option v-for="(item ,index) in selectHour" :key="index" :label="item" :value="item"></el-option>
                        </el-select>
                      </el-form-item>
                      <span style="line-height:40px;padding-right:10px;">点</span>
                      <el-form-item label="备注">
                        <el-input @focus="hideFoot" @blur="showFoot" size="mini" v-model="item.remark" placeholder="如通腹腔" class="inputStyle width100 INPUTS">
                          <template slot="append">&nbsp;</template>
                        </el-input>
                      </el-form-item>
                      <el-form-item label="长度">
                        <el-input @focus="hideFoot" @blur="showFoot" size="mini" v-model="item.length" class="inputStyle width100 INPUTS">
                          <template slot="append">cm</template>
                        </el-input>
                      </el-form-item>
                    </el-col>
                    <span @click="addP('3')">
                      <icon name="add" width="30" height="30"></icon>
                    </span>
                  </el-row>
                </el-form>
                <h6>伤口创面床</h6>
                <el-form label-width="80px" class="woundBed">
                  <el-row>
                    <el-col :span="7" :offset="1">
                      <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].woundBed">
                        <el-checkbox label="1">
                          <el-form-item label="坏死(黑色)">
                            <el-input type="number" class="inputStyle" size="mini" v-model="woundInfoImg.woundInfoList[WI].black" @change="bed(1,woundInfoImg.woundInfoList[WI].black)" @focus="inputFoucs(1)" @blur="inputBlur(1)">
                              <template slot="append">%</template>
                            </el-input>
                          </el-form-item>
                        </el-checkbox>
                      </el-checkbox-group>
                      <template v-if="woundInfoImg.woundInfoList[WI].black>0">
                        <span class="colorSpan" :style="{color:woundInfoImg.woundInfoList[WI].blackColor[index]}"  @click="blackClick(index)"  v-for="(item,index) in allConstList[14]" :key="index">{{item.value}}</span>
                      </template>
                    </el-col>
                    <el-col :span="7" :offset="5">
                      <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].woundBed">
                        <el-checkbox label="2">
                          <el-form-item label="腐肉(黄色)">
                            <el-input type="number" class="inputStyle" size="mini" v-model="woundInfoImg.woundInfoList[WI].yellow" @change="bed(2,woundInfoImg.woundInfoList[WI].yellow)" @focus="inputFoucs(2)" @blur="inputBlur(2)">
                              <template slot="append">%</template>
                            </el-input>
                          </el-form-item>
                        </el-checkbox>
                      </el-checkbox-group>
                      <template v-if="woundInfoImg.woundInfoList[WI].yellow>0">
                        <span class="colorSpan" :style="{color:woundInfoImg.woundInfoList[WI].yellowColor[index]}" @click="yellowClick(index)" v-for="(item,index) in allConstList[14]" :key="index">{{item.value}}</span>
                      </template>
                    </el-col>
                  </el-row>
                  <el-row>
                    <el-col :span="7" :offset="1">
                      <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].woundBed">
                        <el-checkbox label="3">
                          <el-form-item label="肉芽(红色)">
                            <el-input type="number" class="inputStyle" size="mini" v-model="woundInfoImg.woundInfoList[WI].red" @change="bed(3,woundInfoImg.woundInfoList[WI].red)" @focus="inputFoucs(3)" @blur="inputBlur(3)">
                              <template slot="append">%</template>
                            </el-input>
                          </el-form-item>
                        </el-checkbox>
                      </el-checkbox-group>
                      <template v-if="woundInfoImg.woundInfoList[WI].red>0">
                        <span class="colorSpan" :style="{color:woundInfoImg.woundInfoList[WI].redColor[index]}" @click="redClick(index)"  v-for="(item,index) in allConstList[15]" :key="index">{{item.value}}</span>
                      </template>
                    </el-col>
                    <el-col :span="7" :offset="5">
                      <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].woundBed">
                        <el-checkbox label="4">
                        <el-form-item label="上皮(粉红)">
                            <el-input type="number" class="inputStyle" size="mini" v-model="woundInfoImg.woundInfoList[WI].pink" @change="bed(4,woundInfoImg.woundInfoList[WI].pink)" @focus="inputFoucs(4)" @blur="inputBlur(4)">
                              <template slot="append">%</template>
                            </el-input>
                          </el-form-item>
                        </el-checkbox>
                      </el-checkbox-group>
                    </el-col>
                  </el-row>
                  <el-row>
                    <el-form-item label="备注">
                      <el-input @focus="hideFoot" @blur="showFoot" v-model="woundInfoImg.woundInfoList[WI].woundBedRemark"  class="inputStyle"></el-input>
                    </el-form-item>
                  </el-row>
                </el-form>
                <!-- 伤口评估一致多选框 -->
                <el-row v-if="woundInfoImg.woundShape==51&&woundInfoImg.woundInfoList.length >= 2&&WI>0">
                  <el-col :offset="1">
                    <el-checkbox class="FlagStyle" @change="recordFlagChange" v-model="woundInfoImg.woundInfoList[WI].recordFlag">若下列伤口评估内容与伤口1一致，请勾选。</el-checkbox>
                  </el-col>
                </el-row>
                <h6>渗液颜色性状</h6>
                <el-row>
                  <el-col :span="22" :offset="1">
                    <p style="color:#999999;margin:5px 0;padding:5px 0;text-indent:20px;background-color:#f2f2f2">颜色</p>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="7" :offset="1" v-for="(item ,index) in allConstList[0]" :key="index">
                    <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].penetrationColor">
                      <el-checkbox :label="item.id">{{item.value}}</el-checkbox>
                    </el-checkbox-group>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="22" :offset="1" style="">
                    <p style="color:#999999;margin:5px 0;padding:5px 0;text-indent:20px;background-color:#f2f2f2">性状</p>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="7" :offset="1" v-for="(item ,index) in allConstList[1]" :key="index" class="gg">
                    <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].penetrationShape">
                      <el-checkbox :label="item.id">{{item.value}}
                        <!-- <span v-if="item.value=='其他'"><el-input @focus="hideFoot" @blur="showFoot" v-model="woundInfoImg.woundInfoList[WI].penetrationShapeOther" class="elseInput"></el-input></span> -->
                      </el-checkbox>
                    </el-checkbox-group>
                  </el-col>
                </el-row>
                <h6>渗液量</h6>
                <el-row>
                  <el-col :span="7" :offset="1" v-for="(item,index) in allConstList[2]" :key="index">
                    <el-radio-group v-model="woundInfoImg.woundInfoList[WI].penetrationQuantity">
                      <el-radio :label="item.id">{{item.value}}</el-radio>
                    </el-radio-group>
                  </el-col>
                </el-row>
                <h6>气味</h6>
                <el-row>
                  <el-col :span="index*7+7" :offset="1" v-for="(item ,index) in allConstList[3]" :key="index">
                    <el-radio-group v-model="woundInfoImg.woundInfoList[WI].smellList">
                      <el-radio :label="item.id" >{{item.value}}</el-radio>
                    </el-radio-group>
                    <el-row v-if="item.children!=null&&woundInfoImg.woundInfoList[WI].smellList==19&&item.id==19" class="bgc marginTop20">
                      <el-col :span="14">
                        <el-radio-group v-model="woundInfoImg.woundInfoList[WI].smell">
                          <el-radio v-for="(Item,Index) in item.children" :key="Index" :label="Item.id" class="block">{{Item.value}}</el-radio>
                        </el-radio-group>
                      </el-col>
                    </el-row>
                  </el-col>
                </el-row>
                <h6>伤口边缘</h6>
                <el-row>
                  <el-col :span="7" :offset="1" v-for="(item,index) in allConstList[4]" :key="index">
                    <el-checkbox-group  v-model="woundInfoImg.woundInfoList[WI].woundEdge">
                      <el-checkbox :label="item.id">{{item.value}}</el-checkbox>
                    </el-checkbox-group>
                  </el-col>
                </el-row>
                <h6>周围皮肤状态</h6>
                <el-row>
                  <el-col :span="5" :offset="1" v-for="(item,index) in allConstList[5]" :key="index">
                    <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].skinCondition">
                      <el-checkbox :label="item.id">{{item.value}}</el-checkbox>
                    </el-checkbox-group>
                  </el-col>
                </el-row>
                <h6>创面疼痛频率与疼痛程度</h6>
                <el-row>
                  <el-col  class="painLevel">
                    <div>
                      <img class="painImg" src="../../../static/img/1.png" alt="">
                      <p>无痛</p>
                    </div>
                    <div>
                      <img class="painImg" src="../../../static/img/2.png" alt="">
                      <p>有点痛</p>
                    </div>
                    <div>
                      <img class="painImg" src="../../../static/img/3.png" alt="">
                      <p>轻微疼痛</p>
                    </div>
                    <div>
                      <img class="painImg" src="../../../static/img/4.png" alt="">
                      <p>疼痛明显</p>
                    </div>
                    <div>
                      <img class="painImg" src="../../../static/img/5.png" alt="">
                      <p>疼痛严重</p>
                    </div>
                    <div>
                      <img class="painImg" src="../../../static/img/6.png" alt="">
                      <p>剧烈疼痛</p>
                    </div>
                  </el-col>
                </el-row>
                <el-row class="painLevel">
                  <el-col v-for="item in level" :key="item">
                    <el-radio-group v-model="woundInfoImg.woundInfoList[WI].painLevel">
                      <el-radio :label="item">{{item}}</el-radio>
                    </el-radio-group>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="22" :offset="1">
                    <img style="width:100%;height:100%" src="../../../static/img/pain.png" alt="">
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="22" :offset="1">
                    <div class="painDiv">
                      <span class="painSpan">轻度疼痛<br><span style="font-size:12px;color:#ccc;">（不影响睡眠）</span></span>
                      <span class="painSpan">中度疼痛<br><span style="font-size:12px;color:#ccc;">（轻度影响睡眠）</span></span>
                      <span class="painSpan">重度疼痛<br><span style="font-size:12px;color:#ccc;">（疼痛导致不能睡眠 或从睡眠中疼醒）</span></span>
                    </div>
                  </el-col>
                </el-row>
                <el-row style="padding-bottom:10px;">
                  <el-col :span="22" :offset="1">
                    <div class="painDiv1">
                      <span style="font-size:12px">无痛</span>
                      <span style="font-size:12px">剧痛</span>
                    </div>
                  </el-col>
                </el-row>
                <template v-if="woundInfoImg.woundInfoList[WI].painLevel>=4">
                  <h6>止痛药记录</h6>
                  <el-row  class="painLevel1">
                    <el-col :span="5" :offset="1" v-for="(item,index) in allConstList[6]" :key="index">
                      <el-radio-group v-model="woundInfoImg.woundInfoList[WI].painkillers">
                        <el-radio :label="item.id">{{item.value}}<span v-if="item.value=='特殊情况'"><el-input @focus="hideFoot" @blur="showFoot" v-model="woundInfoImg.woundInfoList[WI].painkillersOther" class="elseInput1"></el-input></span></el-radio>
                      </el-radio-group>
                    </el-col>
                  </el-row>
                </template>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="处理方式与敷料类型录入" name="third">
            <div class="tabShow" id="SHOW2">
              <div class="woundNum" style="padding-bottom:5px;position:fixed;z-index:33;background-color:#fff;" v-if="woundInfoImg.woundInfoList.length >= 2||woundInfoImg.woundShape==51">
                <el-button size="mini" v-if="woundInfoImg.woundInfoList.length >= 2" class="buttonBGC3" v-for="(item,index) in woundInfoImg.woundInfoList" :key="index" @click="switchWound(index)">伤口{{index+1}}</el-button>
                <span v-if="woundInfoImg.woundShape==51" style="margin-left:10px"><el-button size="mini" type="primary"  @click="addWound">添加伤口</el-button></span>
              </div>
              <div v-if="woundInfoImg.woundInfoList.length >= 2" style="margin-top:40px"></div>
              <!-- 伤口评估一致多选框 -->
              <el-row v-if="woundInfoImg.woundShape==51&&woundInfoImg.woundInfoList.length >= 2&&WI>0">
                <el-col :offset="1">
                  <el-checkbox class="FlagStyle" @change="checkChange" v-model="woundInfoImg.woundInfoList[WI].processFlag">若处理措施，敷料使用以及其他处理方法与伤口1一致，请勾选。</el-checkbox>
                </el-col>
              </el-row>
              <h6 style="margin-top:0px;">处理措施</h6>
              <p class="textI">清洗</p>
              <el-row>
                <el-col :span="7" :offset="1" v-for="(item, index) in allConstList[9]" :key="index">
                  <!-- <el-radio-group v-model="woundInfoImg.woundInfoList[WI].debrideLiquid">
                    <el-radio :label="item.id">{{item.value}}
                      <el-input @focus="hideFoot" @blur="showFoot" ref="elseRadio" v-model="woundInfoImg.woundInfoList[WI].debrideLiquidOther" v-if="item.value=='其他'"></el-input>
                    </el-radio>
                  </el-radio-group> -->
                   <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].debrideLiquid">
                    <el-checkbox :label="item.id">{{item.value}}
                      <el-input@focus="hideFoot" @blur="showFoot" ref="elseRadio" v-model="woundInfoImg.woundInfoList[WI].debrideLiquidOther" v-if="item.value=='其他'"></el-input>
                    </el-checkbox>
                  </el-checkbox-group>
                </el-col>
              </el-row>
              <p class="textI">清创</p>
              <el-row>
                <el-col :span='7' :offset="1" v-for="(item,index) in allConstList[8]" :key="index">
                  <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].debrideWay">
                    <el-checkbox :label="item.id">{{item.value}}</el-checkbox>
                  </el-checkbox-group>
                </el-col>
              </el-row>
              <p class="textI">辅助治疗</p>
              <el-row>
                <el-col :span='7' :offset="1" v-for="(item,index) in allConstList[13]" :key="index">
                  <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].assistTherapy">
                    <el-checkbox :label="item.id">{{item.value}}
                      <el-input @focus="hideFoot" @blur="showFoot" ref="elseRadio1" v-model="woundInfoImg.woundInfoList[WI].assistTherapyOther" v-if="item.value=='其他'"></el-input>
                    </el-checkbox>
                  </el-checkbox-group>
                </el-col>
              </el-row>
              <h6>敷料种类与名称</h6>
              <div class="radio">
                <el-row class="chuliRadio center" style="margin-bottom:40px;">
                  <el-col :span="6">
                    <div style="position:relative;">
                      <div class="getPhoto"  @click="popover(6)">
                        <div class='putPhoto' v-if="!woundInfoImg.woundInfoList[WI].photo1">
                          <icon name="add" width="25" height="25"></icon>
                          <p>请拍摄敷料1覆盖后伤口情况</p>
                        </div>
                        <input id="camera6" type="file" class="cameraStyle" accept="image/*" capture="camera" @click="cameraClick" @change="cameraChange">
                        <!-- <img :src="woundInfoImg.woundInfoList[WI].photo1" alt="" v-if="woundInfoImg.woundInfoList[WI].photo1" style="width:100%;height:100%;"> -->
                      </div>
                      <img :src="woundInfoImg.woundInfoList[WI].photo1" alt="" v-if="woundInfoImg.woundInfoList[WI].photo1" style="width:100%;height:100%;position:absolute;top:0;left:0;" @click="handleViewImg(6,woundInfoImg.woundInfoList[WI].photo1)">
                      <!-- <el-button type="primary" size="mini" style="position:absolute;width:50%;left:25%;" v-if="woundInfoImg.woundInfoList[WI].photo1"
                       @click="handleLookOne(woundInfoImg.woundInfoList[WI].photo1)">查看</el-button> -->
                    </div>
                  </el-col>
                  <el-col :span="6">
                    <div style="position:relative;">
                      <div class="getPhoto"  @click="popover(9)">
                        <div class='putPhoto' v-if="!woundInfoImg.woundInfoList[WI].photo4">
                          <icon name="add" width="25" height="25"></icon>
                          <p>请拍摄敷料2覆盖后伤口情况</p>
                        </div>
                        <input id="camera9" type="file" class="cameraStyle" accept="image/*" capture="camera" @click="cameraClick" @change="cameraChange">
                        <!-- <img :src="woundInfoImg.woundInfoList[WI].photo4" alt="" v-if="woundInfoImg.woundInfoList[WI].photo4" style="width:100%;height:100%;"> -->
                      </div>
                      <img :src="woundInfoImg.woundInfoList[WI].photo4" alt="" v-if="woundInfoImg.woundInfoList[WI].photo4" style="width:100%;height:100%;position:absolute;top:0;left:0;" @click="handleViewImg(9,woundInfoImg.woundInfoList[WI].photo4)">
                      <!-- <el-button type="primary" size="mini" style="position:absolute;width:50%;left:25%;"   v-if="woundInfoImg.woundInfoList[WI].photo4"
                      @click="handleLookOne(woundInfoImg.woundInfoList[WI].photo4)">查看</el-button> -->
                    </div>
                  </el-col>
                  <el-col :span="6">
                    <div style="position:relative;">
                      <div class="getPhoto"  @click="popover(7)">
                        <div class='putPhoto' v-if="!woundInfoImg.woundInfoList[WI].photo2">
                          <icon name="add" width="25" height="25"></icon>
                          <p>请拍摄敷料包装<br>&nbsp;</p>
                        </div>
                        <input id="camera7" type="file" class="cameraStyle" accept="image/*" capture="camera" @click="cameraClick" @change="cameraChange">
                        <!-- <img :src="woundInfoImg.woundInfoList[WI].photo2" alt="" v-if="woundInfoImg.woundInfoList[WI].photo2" style="width:100%;height:100%;"> -->
                      </div>
                      <img :src="woundInfoImg.woundInfoList[WI].photo2" alt="" v-if="woundInfoImg.woundInfoList[WI].photo2" style="width:100%;height:100%;position:absolute;top:0;left:0;" @click="handleViewImg(7,woundInfoImg.woundInfoList[WI].photo2)">
                      <!-- <el-button type="primary" size="mini" style="position:absolute;width:50%;left:25%;"
                       @click="handleLookOne(woundInfoImg.woundInfoList[WI].photo2)" v-if="woundInfoImg.woundInfoList[WI].photo2">查看</el-button> -->
                    </div>
                  </el-col>
                  <el-col :span='6'></el-col>
                </el-row>
              </div>
              <p class="textI">请记录敷料种类</p>
              <el-row>
                <el-col :span="11" :offset="1" v-for="(item,index) in allConstList[10]" :key="index">
                  <el-checkbox-group v-model="woundInfoImg.woundInfoList[WI].outDressingId" class="checkboxAdd" disabled>
                    <el-checkbox :label="item.id" class="textBreak">{{item.value}}</el-checkbox>
                    <span v-if="item.value!='其他'" class="addSpanStyle" @click="selectDressimgType(index,item.id)"><icon class="icon" name="add1" width="20" height="20"></icon></span>
                    <el-input  @focus="hideFoot" v-if="item.value=='其他'" v-model="woundInfoImg.woundInfoList[WI].dressingOtherNew" @blur="elseInputBlur(item.id)"></el-input>
                  </el-checkbox-group>
                  <p v-if="woundInfoImg.woundInfoList[WI].outDressingId.includes(item.id)" style="padding-left:30px;margin:5px 0;color:#2e96e6">{{woundInfoImg.woundInfoList[WI].dressingTypeName[item.id]}}</p>
                </el-col>
              </el-row>
              <h6>其他处理方法</h6>
              <el-row  class="chuliRadio" style="margin-bottom:50px;">
                <el-col :span="6">
                  <div style="position:relative;">
                    <div class="getPhoto"  @click="popover(8)">
                      <div class='putPhoto' v-if="!woundInfoImg.woundInfoList[WI].photo3">
                        <icon name="add" width="25" height="25"></icon>
                        <p>请拍摄其他处理后情况</p>
                      </div>
                      <input id="camera8" class="cameraStyle" type="file" accept="image/*" capture="camera" @click="cameraClick" @change="cameraChange">
                      <!-- <img :src="woundInfoImg.woundInfoList[WI].photo3" alt="" v-if="woundInfoImg.woundInfoList[WI].photo3" style="width:100%;height:100%;"> -->
                    </div>
                    <img :src="woundInfoImg.woundInfoList[WI].photo3" alt="" v-if="woundInfoImg.woundInfoList[WI].photo3" style="width:100%;height:100%;position:absolute;top:0;left:0;" @click="handleViewImg(8,woundInfoImg.woundInfoList[WI].photo3)">
                    <!-- <el-button type="primary" size="mini" style="position:absolute;width:50%;left:25%;"  v-if="woundInfoImg.woundInfoList[WI].photo3"
                    @click="handleLookOne(woundInfoImg.woundInfoList[WI].photo3)">查看</el-button> -->
                  </div>
                </el-col>
              </el-row>
              <el-row>
                <el-col :span="7" :offset="1" v-for="(item, index) in allConstList[12]" :key="index">
                  <el-radio-group v-model="woundInfoImg.woundInfoList[WI].otherProcess">
                    <el-radio :label="item.id">{{item.value}}
                      <el-input @focus="hideFoot" @blur="showFoot" ref="elseRadio2" v-model="woundInfoImg.woundInfoList[WI].otherProcessOther" v-if="item.value=='其他'"></el-input>
                    </el-radio>
                  </el-radio-group>
                </el-col>
              </el-row>
              <h6>签名</h6>
              <div class="radio writeName">
                <span>护士：</span>
                <el-select class="choosename" v-model="woundInfoImg.nurseName" filterable  placeholder="选择本次记录护士姓名"  >
                   <el-option :value="item.id" :label="item.nurseName" v-for="item in NurseNameList" :key="item.index" style="width:200px"></el-option>
                </el-select>
                <!-- <el-button v-if="!woundInfoImg.nurseName" type="text" @click="handleSignature" class="radioBtn">点击签名</el-button><img id='name1' @click="handleSignature" :src="woundInfoImg.nurseName" v-if="woundInfoImg.nurseName"> -->
                <!-- <el-button v-if="!woundInfoImg.nurseName" type="text" @click="handleSignature" class="radioBtn">点击签名</el-button><img id='name1' @click="handleSignature" :src="woundInfoImg.nurseName" v-if="woundInfoImg.nurseName"> -->
              </div>
              <div id="canvasBox"  v-show="canvasShow">
                <canvas id="canvas" width=0 height=0 style="border:1px solid #828282;background-color:#fff;"></canvas>
                <button class="canvasBtn" @click="clearCanvas">清屏</button><button class="canvasBtn" @click="saveCanvas">保存</button>
              </div>
              <el-row class="BotBut">
                <el-col :span="22" :offset='1' style="display:flex;align-items:space-around;justify-content:space-around">
                  <el-button type="primary" size="mini" @click="submitAll">上传提交</el-button>
                  <el-button type="primary" size="mini" @click="extraSave">保存</el-button>
                  <el-button type="primary" size="mini">生成报告</el-button>
                </el-col>
              </el-row>
            </div>
          </el-tab-pane>
        </el-tabs>
      </el-row>
    </div>
    <Foot v-show="!isFocus" id="Foot" :index="index" :save="save"></Foot>

    <el-dialog title="敷料类型" :visible.sync="dialogVisible" width="50%" center :show-close="false"
          :close-on-click-modal="false"
          :close-on-press-escape="false">
      <div class="dialogDiv">
        <el-radio  v-model="dressingIdNew" class="elseCheck"  @change="hghg(Item.name)" v-for="(Item,Index) in dressingType" :key="Index" :label="Item.id">{{Item.name}}</el-radio>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelElseCheck">取 消</el-button>
        <el-button type="primary" @click="showElseCheck">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="请选择伤口形态" :visible.sync="dialogVisible2" center width="50%" :show-close="false"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
    >
      <el-row style="z-index:9999">
        <el-col :span="24" v-for="(item ,index) in allConstList[7]" :key="index" class="textLeft">
          <el-radio-group v-model="ttc">
            <el-radio :label="item.id">{{item.value}}</el-radio>
          </el-radio-group>
        </el-col>
      </el-row>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取 消</el-button>
        <el-button type="primary" @click="startTakePhoto(2)">确 定</el-button>
      </span>
    </el-dialog>

    <Lookdialog ref="lookimgdialog" ></Lookdialog>

    <Popup ref="popup" @popover="popover"></Popup>
  </div>
</template>

<script>
import Foot from '../../components/footer'
import Lookdialog from './dialog.vue'
import Popup from './Popup.vue'
export default {
  name:'chulifangshi',
  components:{Foot,Lookdialog,Popup},
  data(){
    return{
      isFocus: false,
      save:false,
      recordId:[],
      idList:[],
      woundType:'',
      itemIndex:0,
      woundInfoHistory:[],
      extraNum:0,
      extraID:[],
      extraDis:[],
      placeHolderName:[],
      pShow:false,
      woundGather:[],
      woundTypeName:'',
      woundTypeValue:[],
      extraSelect:[],
      elseWord:'',
      activeName:'first',
      fullscreenLoading:false,
      falseFatherID:null,
      typeName:null,
      ttc:null,
      photoName:[
        {
          value:0,
          name:'敷料渗液&nbsp;'
        },
        {
          value:1,
          name:'清创前&nbsp;'
        },
        {
          value:2,
          name:'清创后&nbsp;'
        },
        {
          value:3,
          name:'健侧对比&nbsp;'
        },
        {
          value:4,
          name:'补充拍摄'
        },
        {
          value:5,
          name:'补充拍摄'
        }
      ],
      photoNumber:null,
      WI:0,
      oldWI:0,
      constList:[],
      allConstList:[],
      selectHour:['1','2','3','4','5','6','7','8','9','10','11','12'],
      level:[0,1,2,3,4,5,6,7,8,9,10],
      woundSize:['潜行','窦道','瘘管'],
      sickData:{},
      dressingIdNew:'',
      titi:1,
      point:{},
      dialogVisible :false,
      dialogVisible2:false,
      canvasShow:false,
      dressingType:[],
      NurseNameList:[],//护士签名下拉列表
      woundInfoImg:{
        id:'',
        woundId:'',
        voices:false,
        voice:null,
        previousExudatePic:null,
        beforeDebridePic:null,
        afterDebridePic:null,
        referencePic:null,
        nearWoundPic:null,
        farWoundPic:null,
        site:'',
        nurseName:'',
        nurseId:'',
        woundShape:null,
        woundType:null,
        woundTypeOther:'',
        woundLevel:'',
        photo:[null,null,null,null,null,null],
        woundInfoList:[
          {
            id:'',
            recordId:'',
            processFlag:false,
            recordFlag:false,
            length:'',
            width:'',
            depth:'',
            volume:'',
            area:'',
            sutureLength:'',
            black:'0',
            red:'0',
            pink:'0',
            yellow:'0',
            penetrationColor:[],
            penetrationShape:[],
            penetrationShapeOther:null,
            penetrationQuantity:null,
            smell:null,
            woundEdge:[],
            painLevel:null,
            painkillers:null,
            painkillersOther:null,
            skinCondition:[],
            debrideWay:[],
            debrideLiquid:[],
            debrideLiquidOther:'',
            afterDressingPic:null,
            dressingPackagePic:null,
            assistTherapy:[],
            dressingIdNew:[],
            dressingOtherNew:'',
            assistTherapyOther: "",
            otherProcessImg:null,
            afterDressingPic2:null,
            otherProcess:'',
            otherProcessOther:'',
            sneakList:[],
            sinusList:[],
            fistulaList:[],
            //敷料选项
            dressingTypeName:[],
            outDressingId:[],
            dressingFatherID:'',
            //paizhao
            photo1:'',
            photo2:'',
            photo3:'',
            photo4:'',
            sneakType:'',
            sneakRemark:'',
            sneakStart:'',
            sneakEnd:'',
            sinusType:'',
            sinusRemark:'',
            sinusStart:'',
            sinusEnd:'',
            blackChildren:[],
            yellowChildren:[],
            redChildren:[],
            woundBedRemark:'',
            blackColor:['#606266','#606266'],
            yellowColor:['#606266','#606266'],
            redColor:['#606266','#606266','#606266','#606266','#606266','#606266'],
            radio:[],
            oldRadio:[],
            woundBed:[],
            smellList:null,
          }
        ]
      },
      index:'2',
      i:''
    }
  },
  beforeRouteLeave(to,from,next){
    this.extraSave()
    next()
  },
  mounted(){
    this.handleGetNameList()
  },
  methods:{
    //预览图片
    handleViewImg(val,src){
        this.$refs.popup.isshow = true
        this.$refs.popup.imgsrc = src
        this.$refs.popup.val = val
     },
    //查看大图
    handleLookIMG(src){
       this.$refs.lookimgdialog.centerDialogVisible = true
       this.$refs.lookimgdialog.imgsrc = src
     },
     //tab3 查看大图
     handleLookOne(src){
      this.$refs.lookimgdialog.centerDialogVisible = true
      this.$refs.lookimgdialog.imgsrc = src
     },
     //删除伤口
     handleDeleteSk(item,index){
      this.$confirm('确认删除此伤口?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
      })
     },
     //签名获取护士下拉列表
     handleGetNameList(){
      this.API.get('/api/user/listNurse').then(res=>{
         if(res&&res.code == 0){
          this.NurseNameList = res.data
         }
      })
     },
    //临时保存
    extraSave(){
      this.$store.commit('setTempData', {
        index: this.itemIndex,
        data: JSON.parse(JSON.stringify(this.woundInfoImg))
      })
      this.$store.commit('setInfoId',this.idList)
      this.save = true
      this.$message({
        type:'success',
        message:'保存成功',
        duration:1000
      })
    },
    //深复制
    deepClone(Obj1, Obj2 = {}) {
      for (var i in Obj1) {
        var prop = Obj1[i]
        if(prop === Obj2) {
        continue
        }
        if (typeof prop === 'object') {
          Obj2[i] = (prop.constructor === Array) ? [] : {}
          deepClone(prop, Obj2[i])
        } else {
          Obj2[i] = prop
        }
      }
      return Obj2
    },
    //伤口创面床黑色备选
    blackClick(index){
      if(this.woundInfoImg.woundInfoList[this.WI].blackColor[index]=='#606266'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].blackColor,index,'#409EFF');
        this.woundInfoImg.woundInfoList[this.WI].blackChildren.push(this.allConstList[14][index].id)
      }else if(this.woundInfoImg.woundInfoList[this.WI].blackColor[index]=='#409EFF'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].blackColor,index,'#606266');
        for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].blackChildren.length;i++){
          if(this.woundInfoImg.woundInfoList[this.WI].blackChildren[i]==this.allConstList[14][index].id){
            this.woundInfoImg.woundInfoList[this.WI].blackChildren.splice(i,1);
            return
          }
        }
      };
    },
    //伤口创面床黄色备选
    yellowClick(index){
      if(this.woundInfoImg.woundInfoList[this.WI].yellowColor[index]=='#606266'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].yellowColor,index,'#409EFF');
        this.woundInfoImg.woundInfoList[this.WI].yellowChildren.push(this.allConstList[14][index].id)
      }else if(this.woundInfoImg.woundInfoList[this.WI].yellowColor[index]=='#409EFF'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].yellowColor,index,'#606266');
        for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].yellowChildren.length;i++){
          if(this.woundInfoImg.woundInfoList[this.WI].yellowChildren[i]==this.allConstList[14][index].id){
            this.woundInfoImg.woundInfoList[this.WI].yellowChildren.splice(i,1);
            return
          }
        }
      };
    },
    //伤口创面床红色备选
    redClick(index){
      if(this.woundInfoImg.woundInfoList[this.WI].redColor[index]=='#606266'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].redColor,index,'#409EFF');
        this.woundInfoImg.woundInfoList[this.WI].redChildren.push(this.allConstList[15][index].id)
      }else if(this.woundInfoImg.woundInfoList[this.WI].redColor[index]=='#409EFF'){
        this.$set(this.woundInfoImg.woundInfoList[this.WI].redColor,index,'#606266');
        for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].redChildren.length;i++){
          if(this.woundInfoImg.woundInfoList[this.WI].redChildren[i]==this.allConstList[15][index].id){
            this.woundInfoImg.woundInfoList[this.WI].redChildren.splice(i,1);
            return
          }
        }
      };
    },
    //评估一致复选框
    recordFlagChange(val){
      if(this.woundInfoImg.woundInfoList[this.WI].recordFlag){
        this.woundInfoImg.woundInfoList[this.WI].penetrationColor=this.woundInfoImg.woundInfoList[0].penetrationColor;
        this.woundInfoImg.woundInfoList[this.WI].penetrationShape=this.woundInfoImg.woundInfoList[0].penetrationShape;
        this.woundInfoImg.woundInfoList[this.WI].penetrationShapeOther=this.woundInfoImg.woundInfoList[0].penetrationShapeOther;
        this.woundInfoImg.woundInfoList[this.WI].penetrationQuantity=this.woundInfoImg.woundInfoList[0].penetrationQuantity;
        this.woundInfoImg.woundInfoList[this.WI].smell=this.woundInfoImg.woundInfoList[0].smell;
        this.woundInfoImg.woundInfoList[this.WI].smellList=this.woundInfoImg.woundInfoList[0].smellList
        this.woundInfoImg.woundInfoList[this.WI].woundEdge=this.woundInfoImg.woundInfoList[0].woundEdge;
        this.woundInfoImg.woundInfoList[this.WI].skinCondition=this.woundInfoImg.woundInfoList[0].skinCondition
        this.woundInfoImg.woundInfoList[this.WI].painLevel=this.woundInfoImg.woundInfoList[0].painLevel;
        this.woundInfoImg.woundInfoList[this.WI].painkillers=this.woundInfoImg.woundInfoList[0].painkillers;
        this.woundInfoImg.woundInfoList[this.WI].painkillersOther=this.woundInfoImg.woundInfoList[0].painkillersOther;
      }else{
        this.woundInfoImg.woundInfoList[this.WI].penetrationColor=[];
        this.woundInfoImg.woundInfoList[this.WI].penetrationShape=[];
        this.woundInfoImg.woundInfoList[this.WI].penetrationShapeOther=null;
        this.woundInfoImg.woundInfoList[this.WI].penetrationQuantity=null;
        this.woundInfoImg.woundInfoList[this.WI].smell=null;
        this.woundInfoImg.woundInfoList[this.WI].smellList=null;
        this.woundInfoImg.woundInfoList[this.WI].woundEdge=[];
        this.woundInfoImg.woundInfoList[this.WI].skinCondition=[];
        this.woundInfoImg.woundInfoList[this.WI].painLevel=null;
        this.woundInfoImg.woundInfoList[this.WI].painkillers=null;
        this.woundInfoImg.woundInfoList[this.WI].painkillersOther=null;
      }
    },
    //评估一致复选框
    checkChange(val){
      if(this.woundInfoImg.woundInfoList[this.WI].processFlag){
        this.woundInfoImg.woundInfoList[this.WI].debrideWay=this.woundInfoImg.woundInfoList[0].debrideWay;
        this.woundInfoImg.woundInfoList[this.WI].debrideLiquid=this.woundInfoImg.woundInfoList[0].debrideLiquid;
        this.woundInfoImg.woundInfoList[this.WI].debrideLiquidOther=this.woundInfoImg.woundInfoList[0].debrideLiquidOther;
        this.woundInfoImg.woundInfoList[this.WI].afterDressingPic=this.woundInfoImg.woundInfoList[0].afterDressingPic;
        this.woundInfoImg.woundInfoList[this.WI].dressingPackagePic=this.woundInfoImg.woundInfoList[0].dressingPackagePic;
        this.woundInfoImg.woundInfoList[this.WI].dressingIdNew=this.woundInfoImg.woundInfoList[0].dressingIdNew;
        this.woundInfoImg.woundInfoList[this.WI].dressingOtherNew=this.woundInfoImg.woundInfoList[0].dressingOtherNew;
        this.woundInfoImg.woundInfoList[this.WI].assistTherapy=this.woundInfoImg.woundInfoList[0].assistTherapy;
        this.woundInfoImg.woundInfoList[this.WI].assistTherapyOther=this.woundInfoImg.woundInfoList[0].assistTherapyOther;
        this.woundInfoImg.woundInfoList[this.WI].otherProcessImg=this.woundInfoImg.woundInfoList[0].otherProcessImg;
        this.woundInfoImg.woundInfoList[this.WI].afterDressingPic2=this.woundInfoImg.woundInfoList[0].afterDressingPic2;
        this.woundInfoImg.woundInfoList[this.WI].otherProcess=this.woundInfoImg.woundInfoList[0].otherProcess;
        this.woundInfoImg.woundInfoList[this.WI].otherProcessOther=this.woundInfoImg.woundInfoList[0].otherProcessOther;
        this.woundInfoImg.woundInfoList[this.WI].dressingTypeName=this.woundInfoImg.woundInfoList[0].dressingTypeName;
        this.woundInfoImg.woundInfoList[this.WI].outDressingId=this.woundInfoImg.woundInfoList[0].outDressingId;
        this.woundInfoImg.woundInfoList[this.WI].dressingFatherID=this.woundInfoImg.woundInfoList[0].dressingFatherID;
        this.woundInfoImg.woundInfoList[this.WI].photo1=this.woundInfoImg.woundInfoList[0].photo1;
        this.woundInfoImg.woundInfoList[this.WI].photo2=this.woundInfoImg.woundInfoList[0].photo2;
        this.woundInfoImg.woundInfoList[this.WI].photo3=this.woundInfoImg.woundInfoList[0].photo3;
        this.woundInfoImg.woundInfoList[this.WI].photo4=this.woundInfoImg.woundInfoList[0].photo4;
      }else{
        this.woundInfoImg.woundInfoList[this.WI].debrideWay=[];
        this.woundInfoImg.woundInfoList[this.WI].debrideLiquid=[];
        this.woundInfoImg.woundInfoList[this.WI].debrideLiquidOther='';
        this.woundInfoImg.woundInfoList[this.WI].afterDressingPic='';
        this.woundInfoImg.woundInfoList[this.WI].dressingPackagePic='';
        this.woundInfoImg.woundInfoList[this.WI].dressingIdNew=[];
        this.woundInfoImg.woundInfoList[this.WI].dressingOtherNew='';
        this.woundInfoImg.woundInfoList[this.WI].assistTherapy=[];
        this.woundInfoImg.woundInfoList[this.WI].assistTherapyOther='';
        this.woundInfoImg.woundInfoList[this.WI].otherProcessImg='';
        this.woundInfoImg.woundInfoList[this.WI].afterDressingPic2='';
        this.woundInfoImg.woundInfoList[this.WI].otherProcess='';
        this.woundInfoImg.woundInfoList[this.WI].otherProcessOther='';
        this.woundInfoImg.woundInfoList[this.WI].dressingTypeName=[];
        this.woundInfoImg.woundInfoList[this.WI].outDressingId=[];
        this.woundInfoImg.woundInfoList[this.WI].dressingFatherID='';
        this.woundInfoImg.woundInfoList[this.WI].photo1='';
        this.woundInfoImg.woundInfoList[this.WI].photo2='';
        this.woundInfoImg.woundInfoList[this.WI].photo3='';
        this.woundInfoImg.woundInfoList[this.WI].photo4='';
      }
    },
    //保存伤口的公共数据
    saveCommonInfo(){
      let data={
        'id':this.recordId[Number(this.itemIndex)],
        'woundId':this.woundInfoHistory[this.itemIndex].woundId,
        'previousExudatePic':this.woundInfoImg.previousExudatePic,
        'beforeDebridePic':this.woundInfoImg.beforeDebridePic,
        'afterDebridePic':this.woundInfoImg.afterDebridePic,
        'referencePic':this.woundInfoImg.referencePic,
        'nearWoundPic':this.woundInfoImg.nearWoundPic,
        'farWoundPic':this.woundInfoImg.farWoundPic,
        'site':this.woundInfoImg.site,
        'voice':this.woundInfoImg.voice,
        'woundShape':this.woundInfoImg.woundShape,
        'nurseId':this.woundInfoImg.nurseName,
        'status':1
      };
      this.API.post('/api/wound/record/add',data)
      .then((res)=>{
        if(res.code==0){
          this.$message({
            type:'success',
            message:res.message,
            duration:1000
          });
          if(this.$store.state.tempData[this.itemIndex]){
            this.$store.commit('setTempData',{
              index:this.itemIndex,
              data:null
            });
          }
          this.$set(this.recordId,this.itemIndex,'')
          this.$store.commit('setRecordId',this.recordId);
          this.$set(this.idList,this.itemIndex,[]);
          this.$store.commit('setInfoId',this.idList);
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
        this.fullscreenLoading=false;
      })
    },
    //保存一个伤口的不同数据
    saveSelfInfo(index, bool = 0){
      // for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.length;i++){
      //   if(typeof(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew[i])!='number'){
      //     this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i,1);
      //     i--;
      //   }
      // };
      const {
        woundInfoImg
      } = this
      const {
        woundInfoList
      }  = woundInfoImg
      let data={
        'id':this.idList[this.itemIndex]? (this.idList[this.itemIndex][index]? this.idList[this.itemIndex][index] : ''):'',
        'recordId':this.recordId[Number(this.itemIndex)],
        'recordFlag':Number(woundInfoList[index].recordFlag),
        'processFlag':Number(woundInfoList[index].processFlag),
        'length':woundInfoList[index].length,
        'width':woundInfoList[index].width,
        'depth':woundInfoList[index].depth,
        'volume':woundInfoList[index].volume,
        'area':woundInfoList[index].area,
        'sutureLength':woundInfoList[index].sutureLength,
        'black':woundInfoList[index].black,
        'yellow':woundInfoList[index].yellow,
        'red':woundInfoList[index].red,
        'pink':woundInfoList[index].pink,
        'penetrationColor':woundInfoList[index].penetrationColor.join(','),
        'penetrationShape':woundInfoList[index].penetrationShape.join(','),
        'penetrationShapeOther':woundInfoList[index].penetrationShapeOther,
        'penetrationQuantity':woundInfoList[index].penetrationQuantity,
        'smell':woundInfoList[index].smell,
        'woundEdge':woundInfoList[index].woundEdge.join(','),
        'painLevel':woundInfoList[index].painLevel,
        'painkillers':woundInfoList[index].painkillers,
        'painkillersOther':woundInfoList[index].painkillersOther,
        'skinCondition':woundInfoList[index].skinCondition.join(','),
        'debrideWay':woundInfoList[index].debrideWay.join(','),
        'debrideLiquid':woundInfoList[index].debrideLiquid.join(','),
        'debrideLiquidOther':woundInfoList[index].debrideLiquidOther,
        'afterDressingPic':woundInfoList[index].afterDressingPic,
        'dressingPackagePic':woundInfoList[index].dressingPackagePic,
        'dressingIdNew':woundInfoList[index].dressingIdNew.join(','),
        'dressingOtherNew':woundInfoList[index].dressingOtherNew,
        'nurseNameNew':woundInfoList[index].nurseNameNew,
        'assistTherapy':woundInfoList[index].assistTherapy.join(','),
        'assistTherapyOther':woundInfoList[index].assistTherapyOther,
        'otherProcessImg':woundInfoList[index].otherProcessImg,
        'afterDressingPic2':woundInfoList[index].afterDressingPic2,
        'otherProcess':woundInfoList[index].otherProcess,
        'otherProcessOther':woundInfoList[index].otherProcessOther,
        'sneakList':woundInfoList[index].sneakList,
        'sinusList':woundInfoList[index].sinusList,
        'fistulaList':woundInfoList[index].fistulaList,
        'sneakType':woundInfoList[index].sneakType,
        'sneakRemark':woundInfoList[index].sneakRemark,
        'sneakStart':woundInfoList[index].sneakStart,
        'sneakEnd':woundInfoList[index].sneakEnd,
        'sinusType':woundInfoList[index].sinusType,
        'sinusRemark':woundInfoList[index].sinusRemark,
        'sinusStart':woundInfoList[index].sinusStart,
        'sinusEnd':woundInfoList[index].sinusEnd,
        'blackChildren':woundInfoList[index].blackChildren.join(','),
        'yellowChildren':woundInfoList[index].yellowChildren.join(','),
        'redChildren':woundInfoList[index].redChildren.join(','),
        'woundBedRemark':woundInfoList[index].woundBedRemark
      }
      this.fullscreenLoading = true
      this.API.post('/api/wound/record/addInfo', data)
      .then((res) => {
        if(res.code === 0){
          if (this.idList[this.itemIndex]) {
            if (!this.idList[this.itemIndex][index]) {
              this.$set(this.idList[this.itemIndex], index,res.data.id)
            }
          }else{
            this.$set(this.idList, this.itemIndex,[]);
            this.$set(this.idList[this.itemIndex], index, res.data.id)
          }
          if (bool === 1) {
            let len = woundInfoList.length
            for (let i=0; i<len; i++) {
              if (i === index + 1 && i < len - 1) {
                for (let i=0; i < woundInfoList[this.WI].dressingIdNew.length; i++) {
                  if (typeof(woundInfoList[this.WI].dressingIdNew[i]) !== 'number') {
                    woundInfoList[this.WI].dressingIdNew.splice(i, 1)
                    i--
                  }
                }
                this.saveSelfInfo(i, 1)
              }else if (i === index+1 && i === len - 1) {
                for (let i=0; i < woundInfoList[this.WI].dressingIdNew.length; i++) {
                  if (typeof(woundInfoList[this.WI].dressingIdNew[i]) !== 'number') {
                    this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i, 1)
                    i--
                  }
                }
                this.saveSelfInfo(i, 2)
              }
            }
          }else if(bool==2){
            this.saveCommonInfo()
          }else{
            this.fullscreenLoading = false
          }
        }else{
          this.$message({
            type: 'info',
            message: res.message,
            duration: 1000
          })
          this.fullscreenLoading = false
        }
      })
      .catch((err)=>{
        this.$message({
          type: 'error',
          message: err.message,
          duration: 1000
        })
        this.fullscreenLoading = false
      })
    },
    //增加伤口记录？
    saveInfo3(show){
      let data={
        'woundId':this.woundInfoHistory[this.itemIndex].woundId,
        'previousExudatePic':'',
        'beforeDebridePic':'',
        'afterDebridePic':'',
        'referencePic':'',
        'nearWoundPic':'',
        'farWoundPic':'',
        'site':this.woundInfoHistory[this.itemIndex].site,
        'voice':'',
        'woundShape':''
      };
      this.API.post('/api/wound/record/add',data)
      .then((res)=>{
        if(res.code==0){
          if(show==1){
            if(!this.recordId[this.itemIndex]){
              this.$set(this.recordId,Number(this.itemIndex),res.data.recordId);
            };
            this.$store.commit('setRecordId',this.recordId);
            this.titi=2;
          }
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
        this.fullscreenLoading=false;
      })
    },
    //底部栏消失
    hideFoot(){
      this.isFocus = true
      document.getElementById('scrolltop').style.height="100%"
    },
    // 底部栏出现
    showFoot(){
      this.isFocus = false
      document.getElementById('scrolltop').style.height='calc(100% - 80px)'
    },
    //选项卡点击
    handleClick(name, oldName) {
      this.$refs.popup.isshow = false
      if(oldName=='first'){
        this.woundInfoHistory[this.itemIndex].secondWoundType=this.woundTypeValue[0];
        if(!this.woundInfoHistory[this.itemIndex].secondWoundType&&!this.woundInfoHistory[this.itemIndex].thirdWoundType){
          this.$message({
            type:'info',
            message:'请先选择伤口类型',
            duration:1000
          });
          return false;
        }else{
          if(this.woundType){
            if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
              this.woundType=this.woundInfoHistory[this.itemIndex].thirdWoundType
            }else{
              this.woundType=this.woundInfoHistory[this.itemIndex].secondWoundType;
            }
            let data={
              'patientId':this.sickData.id,
              'woundType':this.woundType,
              'woundLevel':this.extraSelect[this.woundInfoHistory[this.itemIndex].secondWoundType],
              'woundTypeOther':this.elseWord,
              'id':this.woundInfoHistory[this.itemIndex].woundId
            };
            this.fullscreenLoading=true;
            this.API.post('/api/patient/wound/add',data)
              .then( res=>{
                if(res.code==0){
                  this.getInfoList();
                  this.handleGetNameList()
                  return true;
                }else{
                  this.$message({
                    type:'info',
                    message:res.message,
                    duration:1000
                  });
                  this.fullscreenLoading=false;
                  return false;
                }
              })
              .catch(err=>{
                this.$message({
                  type:'error',
                  message:err.message,
                  duration:1000
                });
                this.fullscreenLoading=false;
                return false;
              })
          }else{
            if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
              this.woundType=this.woundInfoHistory[this.itemIndex].thirdWoundType
            }else{
              this.woundType=this.woundInfoHistory[this.itemIndex].secondWoundType;
            }
            let data={
              'patientId':this.sickData.id,
              'woundType':this.woundType,
              'woundLevel':this.extraSelect[this.woundInfoHistory[this.itemIndex].secondWoundType],
              'woundTypeOther':this.elseWord,
            };
            this.fullscreenLoading=true;
            this.API.post('/api/patient/wound/add',data)
              .then( res=>{
                if(res.code==0){
                  this.getInfoList();
                  return true;
                }else{
                  this.$message({
                    type:'info',
                    message:res.message,
                    duration:1000
                  });
                  this.fullscreenLoading=false;
                  return false;
                }
              })
              .catch(err=>{
                this.$message({
                  type:'error',
                  message:err.message,
                  duration:1000
                });
                this.fullscreenLoading=false;
                return false;
              })
          };
        }
      }else if(oldName!='first'&&name!='first'){
        if(this.woundInfoImg.woundInfoList.length>=2){
          let len=document.getElementsByClassName('buttonBGC').length;
          for(let i=0;i<len;i++){
            document.getElementsByClassName('buttonBGC')[i].style.backgroundColor='rgb(166,166,166)';
            document.getElementsByClassName('buttonBGC3')[i].style.backgroundColor='rgb(166,166,166)';
          }
          document.getElementsByClassName('buttonBGC')[0].style.backgroundColor='#409EFF';
          document.getElementsByClassName('buttonBGC3')[0].style.backgroundColor='#409EFF';
        }
        document.getElementsByClassName('el-tabs__content')[0].scrollTop=0;
        for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.length;i++){
          if(typeof(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew[i])!='number'){
            this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i,1);
            i--;
          }
        };
        let trans=this.WI;
        this.saveSelfInfo(trans);
        this.WI=0;
        return true;
      }
      this.save=false;
    },
    //新增伤口
    addElseWound(){
      let len=this.woundInfoHistory.length;
      let sum=len+1;
      this.$set(this.woundInfoHistory,len,{firstWoundType:'',secondWoundType:'',thirdWoundType:'',woundName:'伤口'+sum,site:''})
    },
    //切换最上面的伤口按钮
    chooseSick(index){
      this.$refs.popup.isshow = false
       if(this.activeName == 'second' || this.activeName == 'third'){
        this.extraSave()
        this.woundInfoImg.photo = [null,null,null,null,null,null]
       }
      //数据初始化
      this.titi=1;
      this.itemIndex=index;
      this.activeName='first';
      this.elseWord='';
      this.woundTypeValue=[];
      this.photoNumber=null;
      this.ttc=null;
      this.WI=0;
      this.woundTypeName='';
      if(document.getElementsByClassName('buttonBGC').length>=2){
        let len=document.getElementsByClassName('buttonBGC').length;
        for(let i=0;i<len;i++){
          document.getElementsByClassName('buttonBGC')[i].style.backgroundColor='rgb(166,166,166)';
          document.getElementsByClassName('buttonBGC3')[i].style.backgroundColor='rgb(166,166,166)';
        }
        document.getElementsByClassName('buttonBGC')[0].style.backgroundColor='#409EFF';
        document.getElementsByClassName('buttonBGC3')[0].style.backgroundColor='#409EFF';
      }
      //临时数据
      if(this.$store.state.tempData[this.itemIndex]){
        this.woundInfoImg=this.$store.state.tempData[this.itemIndex];
      }else{
        // 这里不知道为什么一定要新建一个对象再深拷贝，直接深拷贝就不行
        let temp={};
        temp.woundShape=null;
        temp.voice=null;
        temp.voices=false;
        temp.photo=[null,null,null,null,null,null];
        temp.previousExudatePic=null;
        temp.beforeDebridePic=null;
        temp.afterDebridePic=null;
        temp.referencePic=null;
        temp.nearWoundPic=null;
        temp.farWoundPic=null;
        temp.site=null;
        temp.woundInfoList=[
          {
            id:'',
            recordId:'',
            processFlag:false,
            recordFlag:false,
            length:'',
            width:'',
            depth:'',
            volume:'',
            area:'',
            sutureLength:'',
            black:'0',
            red:'0',
            pink:'0',
            yellow:'0',
            penetrationColor:[],
            penetrationShape:[],
            penetrationShapeOther:null,
            penetrationQuantity:null,
            smell:null,
            woundEdge:[],
            painLevel:null,
            painkillers:null,
            painkillersOther:null,
            skinCondition:[],
            debrideWay:[],
            debrideLiquid:[],
            debrideLiquidOther:'',
            afterDressingPic:null,
            dressingPackagePic:null,
            assistTherapy:[],
            dressingIdNew:[],
            dressingOtherNew:'',
            nurseNameNew:'',
            assistTherapyOther: "",
            otherProcessImg:null,
            afterDressingPic2:null,
            otherProcess:'',
            otherProcessOther:'',
            sneakList:[],
            sinusList:[],
            fistulaList:[],
            outDressingId:[],
            dressingTypeName:[],
            //paizhao
            photo1:'',
            photo2:'',
            photo3:'',
            photo4:'',
            sneakType:'',
            sneakRemark:'',
            sneakStart:'',
            sneakEnd:'',
            sinusType:'',
            sinusRemark:'',
            sinusStart:'',
            sinusEnd:'',
            blackChildren:[],
            yellowChildren:[],
            redChildren:[],
            woundBedRemark:'',
            blackColor:['#606266','#606266'],
            yellowColor:['#606266','#606266'],
            redColor:['#606266','#606266','#606266','#606266','#606266','#606266'],
            radio:[],
            oldRadio:[],
            woundBed:[],
          }
        ];
        temp.site=this.woundInfoHistory[this.itemIndex].site;
        this.woundInfoImg=JSON.parse(JSON.stringify(temp))
      }
      //按钮样式切换
      for(let i=0;i<document.getElementsByClassName('buttonBGC1').length;i++){
        document.getElementsByClassName('buttonBGC1')[i].getElementsByTagName('span')[0].style.width='2.5em';
      }
      document.getElementsByClassName('buttonBGC1')[index].getElementsByTagName('span')[0].style.width='auto';
      let len=document.getElementsByClassName('buttonBGC1').length;
      for(let i=0;i<len;i++){
        document.getElementsByClassName('buttonBGC1')[i].style.backgroundColor='rgb(166,166,166)';
      }
      document.getElementsByClassName('buttonBGC1')[index].style.backgroundColor='#409EFF';
       //分辨出伤口类型
      if(this.woundInfoHistory[this.itemIndex].secondWoundType){
        this.woundTypeValue[0]=this.woundInfoHistory[this.itemIndex].secondWoundType;

        if(this.extraID.includes(this.woundInfoHistory[this.itemIndex].secondWoundType)){
          this.extraSelect[this.woundInfoHistory[this.itemIndex].secondWoundType]=Number(this.woundInfoHistory[this.itemIndex].woundLevel);
          this.woundType=this.woundInfoHistory[this.itemIndex].secondWoundType;
        };
        if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
          this.woundType=this.woundInfoHistory[this.itemIndex].thirdWoundType;
          for(let i=0;i<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children.length;i++){
            if(this.woundInfoHistory[this.itemIndex].secondWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].id&&this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children){
              for(let j=0;j<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children.length;j++){
                if(this.woundInfoHistory[this.itemIndex].thirdWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].id){
                  if(this.woundInfoHistory[this.itemIndex].woundTypeOther){
                    this.elseWord=this.woundInfoHistory[this.itemIndex].woundTypeOther;
                    this.woundTypeName=this.elseWord;
                  }else{
                    this.woundTypeName=this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].name;
                  }
                }
              }
            }
          }
        }
      }
      this.save=false;
    },
    //伤口类型为其他，失去焦点的时候
    blurInput(index,ind){
      if(this.elseWord==''){
        this.woundTypeName='其他'
      }else{
        this.woundTypeName=this.elseWord;
      }
      this.pShow=true;
      document.getElementById('Foot').style.display='block';
      document.getElementById('scrolltop').style.height='calc(100% - 80px)'

    },
    //显示或选择伤口类型名
    selectThirdChild(){
      this.pShow=!this.pShow;
    },
    //清除伤口类型
    cleanTypeName(name){
      this.woundInfoHistory[this.itemIndex].thirdWoundType='';
      this.elseWord='';
    },
    //伤口类型改变
    radioChange(index,ind){
      this.elseWord='';
      let childred=this.woundGather[index].children[ind].children;
      for(let i=0;i<childred.length;i++){
        if(this.woundInfoHistory[this.itemIndex].thirdWoundType==childred[i].id&&childred[i].name!='其他'){
          this.pShow=true;
          this.woundTypeName=childred[i].name;
          this.elseWord='';
        }
      }
    },
    //面积计算
    countArea(){
      if(this.woundInfoImg.woundInfoList[this.WI].length > 999){
        this.woundInfoImg.woundInfoList[this.WI].length = ''
      }

      if(this.woundInfoImg.woundInfoList[this.WI].length>0&&this.woundInfoImg.woundInfoList[this.WI].width>0){
        this.woundInfoImg.woundInfoList[this.WI].area=(this.woundInfoImg.woundInfoList[this.WI].length*this.woundInfoImg.woundInfoList[this.WI].width).toFixed(3);
        this.countVolume();
      };
    },
    //体积计算
    countVolume(){
      if(this.woundInfoImg.woundInfoList[this.WI].area>0&&this.woundInfoImg.woundInfoList[this.WI].depth>0){
        this.woundInfoImg.woundInfoList[this.WI].volume=(this.woundInfoImg.woundInfoList[this.WI].depth*this.woundInfoImg.woundInfoList[this.WI].area).toFixed(3)
      };
    },
    //伤口创面床
    bed(index,data){
      if(data>0){
        // this.woundInfoImg.woundInfoList[this.WI].woundBed.push(index.toString());
      }else{
        for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].woundBed.length;i++){
          if(index==this.woundInfoImg.woundInfoList[this.WI].woundBed[i]){
            this.woundInfoImg.woundInfoList[this.WI].woundBed.splice(i,1);
          }
        }
      }
    },
    //伤口创面床获取焦点
    inputFoucs(val){
      if(val==1){
        if(this.woundInfoImg.woundInfoList[this.WI].black==0){
          this.woundInfoImg.woundInfoList[this.WI].woundBed.push('1');
          this.woundInfoImg.woundInfoList[this.WI].black=''
        }
      }else if(val==2){
        if(this.woundInfoImg.woundInfoList[this.WI].yellow==0){
          this.woundInfoImg.woundInfoList[this.WI].woundBed.push('2');
          this.woundInfoImg.woundInfoList[this.WI].yellow=''
        }
      }else if(val==3){
        if(this.woundInfoImg.woundInfoList[this.WI].red==0){
          this.woundInfoImg.woundInfoList[this.WI].woundBed.push('3');
          this.woundInfoImg.woundInfoList[this.WI].red=''
        }
      }else if(val==4){
        if(this.woundInfoImg.woundInfoList[this.WI].pink==0){
          this.woundInfoImg.woundInfoList[this.WI].woundBed.push('4');
          this.woundInfoImg.woundInfoList[this.WI].pink=''
        }
      };
      document.getElementById('Foot').style.display='none';
      document.getElementById('scrolltop').style.height="100%"
    },
    //伤口创面床失去焦点
    inputBlur(val){
      if(val==1){
        if(this.woundInfoImg.woundInfoList[this.WI].black==''){
          this.woundInfoImg.woundInfoList[this.WI].black='0';
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].woundBed.length;i++){
            if(val==this.woundInfoImg.woundInfoList[this.WI].woundBed[i]){
              this.woundInfoImg.woundInfoList[this.WI].woundBed.splice(i,1);
            }
          }
        }
      }else if(val==2){
        if(this.woundInfoImg.woundInfoList[this.WI].yellow==''){
          this.woundInfoImg.woundInfoList[this.WI].yellow='0';
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].woundBed.length;i++){
            if(val==this.woundInfoImg.woundInfoList[this.WI].woundBed[i]){
              this.woundInfoImg.woundInfoList[this.WI].woundBed.splice(i,1);
            }
          }
        }
      }else if(val==3){
        if(this.woundInfoImg.woundInfoList[this.WI].red==''){
          this.woundInfoImg.woundInfoList[this.WI].red='0';
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].woundBed.length;i++){
            if(val==this.woundInfoImg.woundInfoList[this.WI].woundBed[i]){
              this.woundInfoImg.woundInfoList[this.WI].woundBed.splice(i,1);
            }
          }
        }
      }else if(val==4){
        if(this.woundInfoImg.woundInfoList[this.WI].pink==''){
          this.woundInfoImg.woundInfoList[this.WI].pink='0';
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].woundBed.length;i++){
            if(val==this.woundInfoImg.woundInfoList[this.WI].woundBed[i]){
              this.woundInfoImg.woundInfoList[this.WI].woundBed.splice(i,1);
            }
          }
        }
      };
      document.getElementById('Foot').style.display='block';
      document.getElementById('scrolltop').style.height='calc(100% - 80px)'

    },
    //敷料种类其他
    elseInputBlur(val){
      if(this.woundInfoImg.woundInfoList[this.WI].dressingOtherNew){
        this.woundInfoImg.woundInfoList[this.WI].outDressingId.push(val);
        this.API.get('/api/pub/dressing/get',{'typeId':val})
        .then(res=>{
          this.$set(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew,val,res.data[0].id);
        });
      }else{
        this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(val,1);
        this.woundInfoImg.woundInfoList[this.WI].outDressingId.forEach((value,index)=>{
          if(value==val){
            this.woundInfoImg.woundInfoList[this.WI].outDressingId.splice(index,1);
          }
        })
      }
      document.getElementById('Foot').style.display='block';
      document.getElementById('scrolltop').style.height='calc(100% - 80px)'

    },
    //开始录音
    startVoice(){
      this.$message({
        type:'info',
        message:'开始录音',
        duration:1000
      });
      if(window.android){
        window.android.startVoice();
      }
    },
    //结束录音
    stopVoice(){
      this.$message({
        type:'info',
        message:'录音结束',
        duration:1000
      });
      this.woundInfoImg.voices=true;
      if(window.android){
        window.android.stopVoice();
      }
    },
    //开始播放语音
    startPLay(){
      if(window.android){
        window.android.playVoice(this.woundInfoImg.voice);
      }
    },
    //点击拍照框
    popover(index){
      console.log(index)
      this.photoNumber=index;
      if(index!=2){
        this.startTakePhoto(index);
      }else{
        if(this.woundInfoImg.woundShape&&this.ttc){
          this.startTakePhoto(index);
        }else{
          this.dialogVisible2=true;
        }
      }
    },
    //开始拍照
    startTakePhoto(index){
      if(index==2){
        this.woundInfoImg.woundShape=this.ttc;
        this.dialogVisible2 = false;
      }
      let id='#camera'+index;
      let camera=document.querySelector(id);
      camera.click();
    },
    //input点击
    cameraClick(){
      if(window.android){
        window.android.openCamera();
      }
    },
    //拍照完成
    cameraChange(e){
      let files = e.target.files;
      if(files.length == 0 ){
        let files2 =  window.android.getImg()
        if(!files2){
           this.$message({message: '请重新拍照',type: 'success'})
        }else{
           this.handleuploadfile(files2)
        }
      }else{
        this.handleuploadfile(files)
      }
      // if(files.length>0){
      //   let formData= new FormData();
      //   formData.append("file",files[0]); formData.append("file",files[0]);
      //   this.fullscreenLoading=true;
      //   this.API.post('/api/wound/record/upload',formData,{'Content-Type':'multipart/form-data','API-User-Token':sessionStorage.getItem('token')})
      //     .then(res=>{
      //       if(res.code==0){
      //         if(this.photoNumber==0){
      //           this.woundInfoImg.previousExudatePic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //           console.log(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==1){
      //           this.woundInfoImg.beforeDebridePic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==2){
      //           this.woundInfoImg.afterDebridePic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==3){
      //           this.woundInfoImg.referencePic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==4){
      //           this.woundInfoImg.nearWoundPic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==5){
      //           this.woundInfoImg.farWoundPic=res.data;
      //           this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
      //         }else if(this.photoNumber==6){
      //           this.woundInfoImg.woundInfoList[this.WI].afterDressingPic=res.data;
      //           this.woundInfoImg.woundInfoList[this.WI].photo1=window.URL.createObjectURL(files[0]);
      //         }else if(this.photoNumber==7){
      //           this.woundInfoImg.woundInfoList[this.WI].dressingPackagePic=res.data;
      //            this.woundInfoImg.woundInfoList[this.WI].photo2=window.URL.createObjectURL(files[0])
      //         }else if(this.photoNumber==8){
      //           this.woundInfoImg.woundInfoList[this.WI].otherProcessImg=res.data;
      //           this.woundInfoImg.woundInfoList[this.WI].photo3=window.URL.createObjectURL(files[0])
      //         }else if(this.photoNumber==9){
      //           this.woundInfoImg.woundInfoList[this.WI].afterDressingPic2=res.data;
      //           this.woundInfoImg.woundInfoList[this.WI].photo4=window.URL.createObjectURL(files[0])
      //         }
      //       }else{
      //         this.$message({
      //           type:'info',
      //           message:res.message,
      //           duration:1000
      //         })
      //       }
      //     })
      //     .catch((err)=>{
      //       this.$message({
      //         type:'error',
      //         message:err.message,
      //         duration:1000
      //       })
      //     })
      //     .finally(()=>{
      //       this.fullscreenLoading=false;
      //     })
      // }
    },
    //上传文件
    handleuploadfile(files){
      let formData= new FormData();
      formData.append("file",files[0]); formData.append("file",files[0]);
      this.fullscreenLoading=true;
      this.API.post('/api/wound/record/upload',formData,{'Content-Type':'multipart/form-data','API-User-Token':sessionStorage.getItem('token')})
        .then(res=>{
          if(res.code==0){
            if(this.photoNumber==0){
              this.woundInfoImg.previousExudatePic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
              console.log(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==1){
              this.woundInfoImg.beforeDebridePic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==2){
              this.woundInfoImg.afterDebridePic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==3){
              this.woundInfoImg.referencePic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==4){
              this.woundInfoImg.nearWoundPic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==5){
              this.woundInfoImg.farWoundPic=res.data;
              this.$set(this.woundInfoImg.photo,this.photoNumber,window.URL.createObjectURL(files[0]))
            }else if(this.photoNumber==6){
              this.woundInfoImg.woundInfoList[this.WI].afterDressingPic=res.data;
              this.woundInfoImg.woundInfoList[this.WI].photo1=window.URL.createObjectURL(files[0]);
            }else if(this.photoNumber==7){
              this.woundInfoImg.woundInfoList[this.WI].dressingPackagePic=res.data;
                this.woundInfoImg.woundInfoList[this.WI].photo2=window.URL.createObjectURL(files[0])
            }else if(this.photoNumber==8){
              this.woundInfoImg.woundInfoList[this.WI].otherProcessImg=res.data;
              this.woundInfoImg.woundInfoList[this.WI].photo3=window.URL.createObjectURL(files[0])
            }else if(this.photoNumber==9){
              this.woundInfoImg.woundInfoList[this.WI].afterDressingPic2=res.data;
              this.woundInfoImg.woundInfoList[this.WI].photo4=window.URL.createObjectURL(files[0])
            }
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
          this.fullscreenLoading=false;
        })
    },
    //添加伤口————临时按钮
    addWound(){
      this.woundInfoImg.woundInfoList.push({
          id:'',
          recordId:'',
          processFlag:false,
          recordFlag:false,
          length:'',
          width:'',
          depth:'',
          volume:'',
          area:'',
          sutureLength:'',
          black:'0',
          red:'0',
          pink:'0',
          yellow:'0',
          penetrationColor:[],
          penetrationShape:[],
          penetrationShapeOther:null,
          penetrationQuantity:null,
          smell:null,
          woundEdge:[],
          painLevel:null,
          painkillers:null,
          painkillersOther:null,
          skinCondition:[],
          debrideWay:[],
          debrideLiquid:[],
          debrideLiquidOther:'',
          afterDressingPic:null,
          dressingPackagePic:null,
          assistTherapy:[],
          dressingIdNew:[],
          dressingOtherNew:'',
          nurseNameNew:'',
          assistTherapyOther: "",
          otherProcessImg:null,
          afterDressingPic2:null,
          otherProcess:'',
          otherProcessOther:'',
          sneakList:[],
          sinusList:[],
          fistulaList:[],
          dressingTypeName:[],
          outDressingId:[],
          dressingFatherID:'',
          photo1:'',
          photo2:'',
          photo3:'',
          photo4:'',
          sneakType:'',
          sneakRemark:'',
          sneakStart:'',
          sneakEnd:'',
          sinusType:'',
          sinusRemark:'',
          sinusStart:'',
          sinusEnd:'',

          redChildren:[],
          yellowChildren:[],
          blackChildren:[],
          woundBedRemark:'',
          blackColor:['#606266','#606266'],
          yellowColor:['#606266','#606266'],
          redColor:['#606266','#606266','#606266','#606266','#606266','#606266'],

          radio:[],
          oldRadio:[],
          woundBed:[],
          smellList:null,
        });
    },
    //伤口切换
    switchWound(index){
      this.oldWI=this.WI;
      this.WI=index;
      let len=document.getElementsByClassName('buttonBGC').length;
      for(let i=0;i<len;i++){
        document.getElementsByClassName('buttonBGC')[i].style.backgroundColor='rgb(166,166,166)';
        document.getElementsByClassName('buttonBGC3')[i].style.backgroundColor='rgb(166,166,166)';
      }
      document.getElementsByClassName('buttonBGC')[index].style.backgroundColor='#409EFF';
      document.getElementsByClassName('buttonBGC3')[index].style.backgroundColor='#409EFF';
      for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.length;i++){
        if(typeof(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew[i])!='number'){
          this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i,1);
          i--;
        }
      };
      this.saveSelfInfo(this.oldWI);
    },
    //提交
    submitAll(){
      this.woundInfoImg.nurseId = this.woundInfoImg.nurseName
      if(this.woundInfoImg.site==''){
        this.$message({type:'info',message:'伤口部位不能为空',duration:1000})
        this.activeName = 'second'
      }else{
        if(this.woundInfoImg.voices){
          this.woundInfoImg.voice=window.android.getVoicePath();
        }
        let len=this.woundInfoImg.woundInfoList.length;
        for(let i=0;i<len;i++){
          if(Number(this.woundInfoImg.woundInfoList[i].recordFlag)==0){
            if(this.woundInfoImg.woundInfoList[i].smell==null){
              this.woundInfoImg.woundInfoList[i].smell=this.woundInfoImg.woundInfoList[i].smellList
            }
          }else if(Number(this.woundInfoImg.woundInfoList[i].recordFlag)==1){
            this.woundInfoImg.woundInfoList[i].smell=this.woundInfoImg.woundInfoList[0].smell;
          }
        }
        if(len>=2){
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.length;i++){
            if(typeof(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew[i])!='number'){
              this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i,1);
              i--;
            }
          };
          this.saveSelfInfo(0,1)
        }else{
          for(let i=0;i<this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.length;i++){
            if(typeof(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew[i])!='number'){
              this.woundInfoImg.woundInfoList[this.WI].dressingIdNew.splice(i,1);
              i--;
            }
          };
          this.saveSelfInfo(this.WI,2);
        }
      }
    },
    //潜行
    checkData(val){
      let len=this.woundInfoImg.woundInfoList[this.WI].radio.length,
        len1=this.woundInfoImg.woundInfoList[this.WI].oldRadio.length;
      if(len>len1){
        if(this.woundInfoImg.woundInfoList[this.WI].radio[len-1]==0){
          this.woundInfoImg.woundInfoList[this.WI].sneakList.push({
            type:1,
            length:'',
            startPoint:''
          })
        };
        if(this.woundInfoImg.woundInfoList[this.WI].radio[len-1]==1){
          this.woundInfoImg.woundInfoList[this.WI].sinusList.push({
            type:2,
            length:'',
            startPoint:'',
            endPoint:''
          })
        };
        if(this.woundInfoImg.woundInfoList[this.WI].radio[len-1]==2){
          this.woundInfoImg.woundInfoList[this.WI].fistulaList.push({
            type:3,
            length:'',
            startPoint:'',
            remark:''
          })
        }
      }else if(len1>len){
        for(let i=0;i<len1;i++){
           if(!this.woundInfoImg.woundInfoList[this.WI].radio.includes(this.woundInfoImg.woundInfoList[this.WI].oldRadio[i])){
             if(this.woundInfoImg.woundInfoList[this.WI].oldRadio[i]==0){
              this.woundInfoImg.woundInfoList[this.WI].sneakList.splice(0,Infinity)
             }else if(this.woundInfoImg.woundInfoList[this.WI].oldRadio[i]==1){
               this.woundInfoImg.woundInfoList[this.WI].sinusList.splice(0,Infinity)
             }else if(this.woundInfoImg.woundInfoList[this.WI].oldRadio[i]==2){
               this.woundInfoImg.woundInfoList[this.WI].fistulaList.splice(0,Infinity)
             }
           }
        }
      }
       this.woundInfoImg.woundInfoList[this.WI].oldRadio=this.woundInfoImg.woundInfoList[this.WI].radio;
    },
    //增加潜行
    addP(index){
      if(index==1){
        this.woundInfoImg.woundInfoList[this.WI].sneakList.push({
          type:1,
          length:'',
          startPoint:''
        })
      }else if(index==2){
        this.woundInfoImg.woundInfoList[this.WI].sinusList.push({
          type:2,
          length:'',
          startPoint:'',
          endPoint:''
        })
      }else if(index==3){
        this.woundInfoImg.woundInfoList[this.WI].fistulaList.push({
          type:3,
          length:'',
          startPoint:'',
          remark:''
        })
      }

    },
    //签名
    handleSignature(){
      this.canvasShow=true;
      var cBox=document.getElementById('canvasBox');
      var w=document.body.clientWidth;
      var h=document.body.clientHeight;
      cBox.style.bottom=80+'px';
      var c=document.getElementById('canvas');
      c.width=w-20;
      c.height=h-350;
      c.addEventListener('touchstart', this.start,false);
      c.addEventListener('touchmove', this.move,false);
    },
    //开始签
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
    //正在签
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
    //清除画板
    clearCanvas(){
      var c=document.getElementById('canvas');
      var ctx=c.getContext('2d');
      ctx.clearRect(0,0,canvas.width,canvas.height);
    },
    //保存签名
    saveCanvas(){
      var c=document.getElementById('canvas');
      this.woundInfoImg.nurseName=c.toDataURL();
      this.canvasShow=false;
    },
    //获取敷料名字
    hghg(name){
      this.typeName=name;
    },
    //取消选择敷料类型
    cancelElseCheck(){
      this.dialogVisible = false;
    },
    //确认选择敷料类型
    showElseCheck(){
      this.dialogVisible = false;
      this.woundInfoImg.woundInfoList[this.WI].dressingFatherID=this.falseFatherID;
      this.$set(this.woundInfoImg.woundInfoList[this.WI].dressingTypeName,this.falseFatherID,this.typeName)
      this.$set(this.woundInfoImg.woundInfoList[this.WI].dressingIdNew,Number(this.falseFatherID),this.dressingIdNew)
      this.dressingIdNew='';
      this.typeName=null;
      this.falseFatherID=null;
      this.woundInfoImg.woundInfoList[this.WI].outDressingId.push(this.woundInfoImg.woundInfoList[this.WI].dressingFatherID)
    },
    //获取常量列表
    getAllConstList(){
      this.fullscreenLoading=true;
      this.API.get('/api/pub/const/listType')
      .then( res=>{
        if(res.code==0){
          this.constList=res.data;
          this.$store.commit('setConstList',res.data);
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
        this.fullscreenLoading=false;
      })
    },
    //分类获取不同类型的子常量列表
    getSonConstList(constType,i){
      this.API.get('/api/pub/const/get',{'type':constType})
      .then(res=>{
        if(res.code==0){
          this.$set(this.allConstList,i,res.data);
          if(i==15) {
            this.$store.commit('setAllConst', this.allConstList)
          }
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
    },
    //获取辅料的子类
    selectDressimgType(index,id){
      this.falseFatherID=id;
      this.fullscreenLoading=true;
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
        this.fullscreenLoading=false;
      })
    },
    //获取所有的伤口类型列表
    getAllWound(){
      this.fullscreenLoading=true;
      this.API.get('/api/wound/type/list')
      .then(res=>{
        if(res.code==0){
          this.$store.commit('setWoundType',res.data);
          this.woundGather=res.data;
          for(let i=0;i<this.woundGather.length;i++){
            for(let j=0;j<this.woundGather[i].children.length;j++){
              if(this.woundGather[i].children[j].woundLevel.length>0){
                this.$set(this.extraSelect,this.woundGather[i].children[j].id,'');
                this.extraNum++;
                this.extraID.push(this.woundGather[i].children[j].id);
                this.$set(this.extraDis,this.woundGather[i].children[j].id,true);
                if(this.woundGather[i].children[j].id==12){
                  this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分期`);
                };
                if(this.woundGather[i].children[j].id==18){
                  this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分级`);
                };
                if(this.woundGather[i].children[j].id==19){
                  this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分期`);
                };
              }
            }
          };
          if(this.woundInfoHistory.length>0){
            if(this.woundInfoHistory[this.itemIndex].firstWoundType){
              if(this.woundInfoHistory[this.itemIndex].secondWoundType){
                this.$set(this.woundTypeValue,0,this.woundInfoHistory[this.itemIndex].secondWoundType);
                if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
                  for(let i=0;i<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children.length;i++){
                    if(this.woundInfoHistory[this.itemIndex].secondWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].id&&this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children){
                      for(let j=0;j<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children.length;j++){
                        if(this.woundInfoHistory[this.itemIndex].thirdWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].id){
                          if(this.woundInfoHistory[this.itemIndex].woundTypeOther){
                            this.elseWord=this.woundInfoHistory[this.itemIndex].woundTypeOther;
                            this.woundTypeName=this.elseWord;
                          }else{
                            this.woundTypeName=this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].name;
                          }
                        }
                      }
                    }
                  }
                }
              }
            };
            if(this.woundInfoHistory[this.itemIndex].woundLevel){
              this.$set(this.extraSelect,this.woundInfoHistory[this.itemIndex].secondWoundType,Number(this.woundInfoHistory[this.itemIndex].woundLevel));
            };
          }
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
        this.fullscreenLoading=false;
      })
    },
    getInfoList(show=true){
      this.API.get('/api/patient/info/getWoundList',{'patientId':this.sickData.id})
      .then((res)=>{
        if(res.code==0){
          this.$store.commit('setHistory',res.data);
          if(show){
            this.woundInfoHistory=this.$store.state.woundInfoHistory;
            this.saveInfo3(this.titi);
          }else{
            this.fullscreenLoading=false;
          }
        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          });
          this.fullscreenLoading=false;
        }
      })
      .catch((err)=>{
        this.$message({
          type:'error',
          message:err.message,
          duration:1000
        });
        this.fullscreenLoading=false;
      })
    },
  },
  computed:{
    //疼痛度显示
    painShow () {
      if(this.woundInfoImg.woundPainLevel>=4){
        return true
      }
      return false
    },
    //潜行显示
    qianXing () {
      if(this.woundInfoImg.woundInfoList[this.WI].radio.includes(0)){
        return true
      }
      return false
    },
    //窦道显示
    douDao () {
      if(this.woundInfoImg.woundInfoList[this.WI].radio.includes(1)){
        return true
      }
      return false
    },
    //瘘管显示
    louGuan () {
      if(this.woundInfoImg.woundInfoList[this.WI].radio.includes(2)){
        return true
      }
      return false
    },
  },
  watch:{
    //常量列表
    constList(){
      for(let i=0;i<this.constList.length;i++){
         this.getSonConstList(this.constList[i].type,i);
      };
    },
    woundTypeValue(val){
       if(this.woundTypeValue.length>1){
         this.woundTypeValue.splice(0,this.woundTypeValue.length-1);
         this.woundInfoHistory[this.itemIndex].secondWoundType=this.woundTypeValue[0];
         this.woundInfoHistory[this.itemIndex].thirdWoundType='';
       };
      for(let i=0;i<val.length;i++){
        if(val[i]=='undefined'||val[i]==undefined||val[i]==null||val[i]=='null'){
          this.woundTypeValue.splice(i,1);
        }
      };
      for(let j=0;j<this.extraID.length;j++){
         if(this.woundTypeValue[0]!=this.extraID[j]){
           this.extraSelect[this.extraID[j]]='';
           this.extraDis[this.extraID[j]]=true;
         }else{
           this.extraDis[this.extraID[j]]=false;
         }
      };
      this.pShow=false;
      if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
        this.pShow=true;
      };
    }
  },
  created(){
    //获取患者基本信息
    this.sickData=this.$store.state.sickMessage;
    //获取所有的常量列表
    if(this.$store.state.allConst.length>0){
      this.allConstList=this.$store.state.allConst;
    }else{
      if(this.$store.state.allConstList.length==0){
        this.getAllConstList();
      }else{
        this.constList=this.$store.state.allConstList;
      }
    }
    //获取患者的所有伤口
    this.woundInfoHistory=this.$store.state.woundInfoHistory;
    if(this.woundInfoHistory.length>0){
      this.$set(this.woundTypeValue,0,this.woundInfoHistory[this.itemIndex].secondWoundType);
      this.woundType=this.woundInfoHistory[this.itemIndex].woundType;

    }else if(this.woundInfoHistory.length==0){
      this.$set(this.woundInfoHistory,0,{firstWoundType:'',secondWoundType:'',thirdWoundType:'',woundName:'伤口1',site:''})
    };
    this.woundInfoImg.site=this.woundInfoHistory[this.itemIndex].site;
    if(this.$store.state.allWoundType.length>0){
      this.woundGather=this.$store.state.allWoundType;
      for(let i=0;i<this.woundGather.length;i++){
        for(let j=0;j<this.woundGather[i].children.length;j++){
          if(this.woundGather[i].children[j].woundLevel.length>0){
            this.$set(this.extraSelect,this.woundGather[i].children[j].id,'');
            this.extraNum++;
            this.extraID.push(this.woundGather[i].children[j].id);
            this.$set(this.extraDis,this.woundGather[i].children[j].id,true);
            if(this.woundGather[i].children[j].id==12){
              this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分期`);
            };
            if(this.woundGather[i].children[j].id==18){
              this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分级`);
            };
            if(this.woundGather[i].children[j].id==19){
              this.$set(this.placeHolderName,this.woundGather[i].children[j].id,`选择分期`);
            };
          }
        }
      };
      if(this.woundInfoHistory.length>0){
        if(this.woundInfoHistory[this.itemIndex].firstWoundType){
          if(this.woundInfoHistory[this.itemIndex].secondWoundType){
            this.$set(this.woundTypeValue,0,this.woundInfoHistory[this.itemIndex].secondWoundType);
            if(this.woundInfoHistory[this.itemIndex].thirdWoundType){
              for(let i=0;i<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children.length;i++){
                if(this.woundInfoHistory[this.itemIndex].secondWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].id&&this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children){
                  for(let j=0;j<this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children.length;j++){
                    if(this.woundInfoHistory[this.itemIndex].thirdWoundType==this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].id){
                      if(this.woundInfoHistory[this.itemIndex].woundTypeOther){
                        this.elseWord=this.woundInfoHistory[this.itemIndex].woundTypeOther;
                        this.woundTypeName=this.elseWord;
                      }else{
                        this.woundTypeName=this.woundGather[this.woundInfoHistory[this.itemIndex].firstWoundType-1].children[i].children[j].name;
                      }
                    }
                  }
                }
              }
            }
          }
        };
        if(this.woundInfoHistory[this.itemIndex].woundLevel){
          this.$set(this.extraSelect,this.woundInfoHistory[this.itemIndex].secondWoundType,Number(this.woundInfoHistory[this.itemIndex].woundLevel));
        };
      }
    }else{
      this.getAllWound();
    };
    this.recordId=this.$store.state.recordId;
    this.idList=this.$store.state.infoId;
    //如果存在临时记录，就拿过来用
    if(this.$store.state.tempData[this.itemIndex]){
      this.woundInfoImg=this.$store.state.tempData[this.itemIndex]
    }
  },
}
</script>

<style >
@import url('./chulifangshi.css');
.writeName .el-input__suffix {
  right: -36px;
  /* transition: all .3s; */
}
#chulifangshi #SHOW2 .el-input {
  max-width: 134px;
}
#chulifangshi #SHOW2 .el-input__inner {
   width: 132%;
   max-width: 166px;
}
</style>
