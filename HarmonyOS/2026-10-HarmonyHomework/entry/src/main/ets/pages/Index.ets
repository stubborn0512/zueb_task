/**
 * HarmonyHomework 综合作业入口页面
 * 归档来源：本会话最后一次提供的修复包；并未在用户本机实际编译验证。
 */
import { preferences } from '@kit.ArkData';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  @State isLoggedIn: boolean = false;
  @State userName: string = '';
  @State showLogin: boolean = false;
  @State usernameInput: string = '';
  @State passwordInput: string = '';
  @State scaleValue: number = 1;
  @State draggedX: number = 0;
  @State draggedY: number = 0;
  @State messages: string[] = ['Preference 示例：可以存储、读取和删除数据'];
  @State prefInput: string = 'hello preferences';

  private tabs: string[] = ['推荐', '数码', '生活'];
  private products: Array<Array<{ name: string; price: string; desc: string }>> = [
    [
      { name: '无线耳机', price: '¥129', desc: '轻巧便携，日常通勤' },
      { name: '便携水杯', price: '¥39', desc: '简约设计，随身携带' },
      { name: '桌面台灯', price: '¥89', desc: '柔和照明' },
      { name: '收纳背包', price: '¥159', desc: '多隔层收纳' },
      { name: '记事本', price: '¥19', desc: '记录灵感' }
    ],
    [
      { name: '蓝牙音箱', price: '¥199', desc: '清晰音效' },
      { name: '手机支架', price: '¥29', desc: '多角度调节' },
      { name: '充电线', price: '¥25', desc: '耐用编织线' },
      { name: '无线鼠标', price: '¥79', desc: '办公学习' },
      { name: '键盘', price: '¥149', desc: '舒适敲击' }
    ],
    [
      { name: '保温杯', price: '¥59', desc: '长效保温' },
      { name: '午睡枕', price: '¥49', desc: '舒适支撑' },
      { name: '小风扇', price: '¥35', desc: '清凉便携' },
      { name: '帆布袋', price: '¥22', desc: '环保实用' },
      { name: '暖光灯', price: '¥69', desc: '温馨氛围' }
    ]
  ];

  build() {
    Column() {
      if (this.showLogin) {
        this.loginPage()
      } else {
        this.homePage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }

  @Builder
  homePage() {
    Column({ space: 12 }) {
      Row() {
        Text('Harmony 商城')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.isLoggedIn ? '已登录' : '登录')
          .fontColor('#2878FF')
          .onClick(() => this.showLogin = true)
      }
      .padding(16)
      .backgroundColor(Color.White)

      Row() {
        Column({ space: 4 }) {
          Text(this.isLoggedIn ? '欢迎您，' + this.userName : '欢迎您，请登录')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text(this.isLoggedIn ? '欢迎回来，祝您购物愉快' : '登录后即可体验购买功能')
            .fontSize(12)
            .fontColor('#777777')
        }
        Blank()
        Button(this.isLoggedIn ? '退出登录' : '立即登录')
          .onClick(() => {
            if (this.isLoggedIn) {
              this.isLoggedIn = false;
              this.userName = '';
            } else {
              this.showLogin = true;
            }
          })
      }
      .padding(16)
      .backgroundColor(Color.White)

      Row({ space: 12 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(16)
            .fontWeight(this.selectedTab === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.selectedTab === index ? '#2878FF' : '#666666')
            .padding({ left: 14, right: 14, top: 8, bottom: 8 })
            .backgroundColor(this.selectedTab === index ? '#E7F0FF' : Color.White)
            .borderRadius(16)
            .onClick(() => this.selectedTab = index)
        })
      }
      .padding({ left: 16, right: 16 })

      List({ space: 10 }) {
        ForEach(this.products[this.selectedTab], (product: { name: string; price: string; desc: string }) => {
          ListItem() {
            Row({ space: 12 }) {
              Column() {
                Text(product.name.substring(0, 1))
                  .fontSize(30)
                  .fontColor('#2878FF')
              }
              .width(68)
              .height(68)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#E7F0FF')
              .borderRadius(12)

              Column({ space: 6 }) {
                Text(product.name).fontSize(17).fontWeight(FontWeight.Medium)
                Text(product.desc).fontSize(12).fontColor('#777777')
                Text(product.price).fontSize(16).fontColor('#E64A35').fontWeight(FontWeight.Bold)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('查看').fontColor('#2878FF')
            }
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .onClick(() => {
              if (!this.isLoggedIn) {
                this.showLogin = true;
                promptAction.showToast({ message: '请先登录' });
              } else {
                promptAction.showToast({ message: '购买成功：' + product.name });
              }
            })
          }
        })
      }
      .padding({ left: 16, right: 16 })
      .layoutWeight(1)

      Scroll() {
        Column({ space: 12 }) {
          Text('作业一：Gesture 手势示例').fontSize(18).fontWeight(FontWeight.Bold)

          Image($r('app.media.app_icon'))
            .width(110)
            .height(110)
            .scale({ x: this.scaleValue, y: this.scaleValue })
            .gesture(
              TapGesture({ count: 2 })
                .onAction(() => this.scaleValue = this.scaleValue === 1 ? 1.5 : 1)
            )
            .gesture(
              PinchGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.scaleValue = Math.max(0.5, Math.min(3, event.scale));
                })
            )

          Text('双击图片放大/还原，双指捏合缩放').fontSize(12).fontColor('#777777')
          Text('拖动示例控件').fontSize(15).fontWeight(FontWeight.Medium)

          Text('拖我')
            .padding(16)
            .backgroundColor('#DCEAFF')
            .borderRadius(8)
            .translate({ x: this.draggedX, y: this.draggedY })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.draggedX = event.offsetX;
                  this.draggedY = event.offsetY;
                })
            )

          Text('作业三：Preferences 数据存储').fontSize(18).fontWeight(FontWeight.Bold)
          TextInput({ text: this.prefInput, placeholder: '输入要保存的值' })
            .onChange((value: string) => this.prefInput = value)

          Row({ space: 8 }) {
            Button('保存').onClick(() => this.savePreference())
            Button('读取').onClick(() => this.readPreference())
            Button('删除').onClick(() => this.deletePreference())
          }

          ForEach(this.messages, (message: string) => {
            Text(message).fontSize(13).fontColor('#555555')
          })
        }
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
      }
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  loginPage() {
    Column({ space: 18 }) {
      Row() {
        Text('返回')
          .fontColor('#2878FF')
          .onClick(() => this.showLogin = false)
        Blank()
        Text('用户登录').fontSize(22).fontWeight(FontWeight.Bold)
        Blank()
        Text('　')
      }
      .width('100%')

      Text('登录后即可购买商品').fontColor('#777777')

      TextInput({ text: this.usernameInput, placeholder: '请输入用户名' })
        .onChange((value: string) => this.usernameInput = value)

      TextInput({ text: this.passwordInput, placeholder: '请输入密码' })
        .type(InputType.Password)
        .onChange((value: string) => this.passwordInput = value)

      Button('登录')
        .width('100%')
        .onClick(() => {
          if (!this.usernameInput.trim() || !this.passwordInput) {
            promptAction.showToast({ message: '请输入用户名和密码' });
            return;
          }
          this.userName = this.usernameInput.trim();
          this.isLoggedIn = true;
          this.showLogin = false;
          promptAction.showToast({ message: '登录成功' });
        })
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  private async savePreference() {
    try {
      let pref = await preferences.getPreferences(getContext(this), { name: 'homework_preferences' });
      await pref.put('demo_key', this.prefInput);
      await pref.flush();
      this.messages = ['已保存并落盘：' + this.prefInput];
      promptAction.showToast({ message: '保存成功' });
    } catch (error) {
      this.messages = ['保存失败：' + JSON.stringify(error)];
    }
  }

  private async readPreference() {
    try {
      let pref = await preferences.getPreferences(getContext(this), { name: 'homework_preferences' });
      let value = await pref.get('demo_key', '');
      this.messages = ['读取结果：' + String(value)];
    } catch (error) {
      this.messages = ['读取失败：' + JSON.stringify(error)];
    }
  }

  private async deletePreference() {
    try {
      let pref = await preferences.getPreferences(getContext(this), { name: 'homework_preferences' });
      await pref.delete('demo_key');
      await pref.flush();
      this.messages = ['已删除 demo_key 并完成落盘'];
      promptAction.showToast({ message: '删除成功' });
    } catch (error) {
      this.messages = ['删除失败：' + JSON.stringify(error)];
    }
  }
}
