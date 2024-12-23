import { MoorWebviewPage } from '@moor/visitor_websdk';
import { router } from '@kit.ArkUI';

@Entry({ routeName: 'moor_MyNavigator' })
@Component
export struct MyNavigator {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @Provide('moorUrl') moorUrl:string = '';

  @Builder
  PageMap(name: string) {
    if (name === "NavDestinationTitle1") {
      pageOneTmp()
    }
  }

  async aboutToAppear(): Promise<void> {
    const params = router.getParams() as Record<string, string>; // 获取传递过来的参数对象

    if (params) {
      this.moorUrl = params.moor_url as string; //取值moor_url
    }
  }

  build() {
    Column() {
      Navigation(this.pageInfos) {
        List({ space: 12 }) {
          ListItem() {
            Text("开始会话")
              .width("100%")
              .height(72)
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .fontSize(16)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
              .onClick(()=>{
                this.pageInfos.pushPath({ name: "NavDestinationTitle1"})
              })
          }
        }
        .width("90%")
        .margin({ top: 12 })
      }
      .title ("Navigation测试")
      .mode(NavigationMode.Auto)
      .navDestination(this.PageMap)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Component
export struct pageOneTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('moorUrl') moorUrl: string;
  build() {
    NavDestination() {
      MoorWebviewPage({
        moor_url: this.moorUrl as string
      })
    }.hideTitleBar(true)
    // .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM],[LayoutSafeAreaEdge.TOP])
    // .expandSafeArea()
  }
}