import { hilog } from '@kit.PerformanceAnalysisKit';
import { router } from '@kit.ArkUI';

import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl } from '@kit.AbilityKit';
import { MoorWebviewPage } from '@moor/visitor_websdk';
import '@moor/visitor_websdk/src/main/ets/pages/MoorWebviewPage';  // 引入共享包中的命名路由页面

let hi: string = 'hello';

@Entry
@Component
struct Index {

  build() {
    Column() {

      Text("7moor demo")
        .id('tittle')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)


      Text("").height('2%')


      TextInput({
        placeholder: '输入在pc配置的访客端页面地址'
      }).fontSize(20)
        .width('90%')
        .onChange((value :string )=>{
          console.info(value);
          hi=value;
        })

      Text("").height('2%')


      Button('进入', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .width(90)
        .height(40)
        .onClick(() => {
          hilog.info(0x0000, 'Button', '点击进入', 'go');
          let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();

          // atManager.requestPermissionsFromUser(getContext(this), ['ohos.permission.CAMERA','ohos.permission.MICROPHONE']).then(async () => {




            try {
              router.pushNamedRoute({
                name: 'moor_WebviewPage',
                params: {
                  //moor_url参数，后台创建的访客端链接
                  moor_url:hi
                }
              })
            } catch (err) {
              let message = (err as BusinessError).message
              let code = (err as BusinessError).code
              console.error(`pushNamedRoute failed, code is ${code}, message is ${message}`);
            }


          // })


        })
    }
    .height('100%')
    .width('100%')
    .offset({ y: 30 })
  }
}