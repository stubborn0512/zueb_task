import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';

interface Product {
  id: number;
  name: string;
  desc: string;
  price: string;
  category: string;
}

@Entry
@Component
struct Index {
  @State page: string = 'shop';
  @State activeTab: string = '热门推荐';
  @State username: string = '';
  @State password: string = '';
  @State loggedIn: boolean = false;
  @State loginName: string = '';
  @State loginUser: string = '';
  @State loginPwd: string = '';
  @State zoom: number = 1;
  @State pinchScale: number = 1;
  @State dragX: number = 0;
  @State dragY: number = 0;
  @State swipeOffsets: number[] = [0, 0, 0, 0, 0];
  @State deletedIds: number[] = [];
  @State prefKey: string = 'nickname';
  @State prefValue: string = '果果';
  @State prefOutput: string = '尚未执行操作';
  private prefStore: preferences.Preferences | undefined = undefined;

  private products: Product[] = [
    { id: 1, name: 'HarmonyOS 智能手表', desc: '轻盈设计 · 全天候健康监测', price: '¥899', category: '热门推荐' },
    { id: 2, name: '无线蓝牙耳机', desc: '主动降噪 · 高清音质', price: '¥299', category: '热门推荐' },
    { id: 3, name: '智能平板电脑', desc: '高清屏幕 · 高效学习', price: '¥1899', category: '热门推荐' },
    { id: 4, name: '便携充电宝', desc: '大容量 · 双向快充', price: '¥129', category: '热门推荐' },
    { id: 5, name: '无线鼠标', desc: '静音点击 · 舒适握持', price: '¥69', category: '热门推荐' },
    { id: 6, name: '轻薄笔记本', desc: '高性能 · 长续航', price: '¥4299', category: '数码办公' },
    { id: 7, name: '机械键盘', desc: '清脆手感 · 多设备连接', price: '¥239', category: '数码办公' },
    { id: 8, name: 'USB-C 扩展坞', desc: '多接口 · 高速传输', price: '¥159', category: '数码办公' },
    { id: 9, name: '显示器支架', desc: '自由调节 · 节省桌面空间', price: '¥99', category: '数码办公' },
    { id: 10, name: '桌面音箱', desc: '立体声 · 简约外观', price: '¥199', category: '数码办公' },
    { id: 11, name: '运动手环', desc: '运动记录 · 睡眠监测', price: '¥199', category: '穿戴设备' },
    { id: 12, name: '智能手表表带', desc: '亲肤材质 · 快拆设计', price: '¥49', category: '穿戴设备' },
    { id: 13, name: '运动耳机', desc: '稳固佩戴 · 防汗设计', price: '¥169', category: '穿戴设备' },
    { id: 14, name: '智能体脂秤', desc: '数据同步 · 多项分析', price: '¥119', category: '穿戴设备' },
    { id: 15, name: '便携运动水杯', desc: '轻巧耐用 · 密封防漏', price: '¥39', category: '穿戴设备' }
  ];

  private showMessage(message: string): void {
    this.getUIContext().getPromptAction().showToast({ message: message, duration: 1800 });
  }

  private visibleProducts(): Product[] {
    return this.products.filter((item: Product) => item.category === this.activeTab && !this.deletedIds.includes(item.id));
  }

  private openProduct(item: Product): void {
    if (!this.loggedIn) {
      this.page = 'login';
      this.showMessage('请先登录后再购买');
    } else {
      this.showMessage('购买成功：' + item.name);
    }
  }

  private async initPreferences(): Promise<void> {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      this.prefStore = await preferences.getPreferences(context, { name: 'homework_preferences' });
      this.prefOutput = 'Preference 初始化成功';
    } catch (error) {
      this.prefOutput = '初始化失败：请检查当前 SDK 的 ArkData Preferences API';
    }
  }

  private async savePreference(): Promise<void> {
    try {
      if (this.prefStore === undefined) await this.initPreferences();
      if (this.prefStore !== undefined) {
        await this.prefStore.put(this.prefKey, this.prefValue);
        await this.prefStore.flush();
        this.prefOutput = \`已存储并落盘：\${this.prefKey} = \${this.prefValue}\`;
      }
    } catch (error) { this.prefOutput = '存储失败，请查看运行日志'; }
  }

  private async readPreference(): Promise<void> {
    try {
      if (this.prefStore === undefined) await this.initPreferences();
      if (this.prefStore !== undefined) {
        const value = await this.prefStore.get(this.prefKey, '（不存在）');
        this.prefOutput = \`读取结果：\${this.prefKey} = \${String(value)}\`;
      }
    } catch (error) { this.prefOutput = '读取失败，请查看运行日志'; }
  }

  private async deletePreference(): Promise<void> {
    try {
      if (this.prefStore === undefined) await this.initPreferences();
      if (this.prefStore !== undefined) {
        await this.prefStore.delete(this.prefKey);
        await this.prefStore.flush();
        this.prefOutput = \`已删除键：\${this.prefKey}，并完成落盘\`;
      }
    } catch (error) { this.prefOutput = '删除失败，请查看运行日志'; }
  }

  aboutToAppear(): void {
    this.initPreferences();
  }

  build() {
    Column() {
      Row() {
        Text('HarmonyOS 综合作业').fontSize(20).fontWeight(FontWeight.Bold).fontColor(Color.White)
        Blank()
        Text('ArkTS').fontSize(12).fontColor('#DCE7FF')
      }.width('100%').padding({ left: 18, right: 18, top: 15, bottom: 15 }).backgroundColor('#202632')

      if (this.page === 'shop') {
        Column() {
          Row() {
            Text('商品列表').fontSize(21).fontWeight(FontWeight.Bold)
            Blank()
            Text(this.loggedIn ? \`欢迎您，\${this.loginName}\` : '欢迎您，请登录').fontSize(13).fontColor('#D84B4B')
          }.width('100%').padding({ top: 18, bottom: 15, left: 16, right: 16 })
          Row() {
            ForEach(['热门推荐', '数码办公', '穿戴设备'], (tab: string) => {
              Column() {
                Text(tab).fontSize(14).fontColor(this.activeTab === tab ? '#2367E8' : '#555555')
                Divider().color(this.activeTab === tab ? '#2367E8' : '#FFFFFF').strokeWidth(3).margin({ top: 8 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Center).onClick(() => { this.activeTab = tab; })
            })
          }.width('100%').padding({ left: 10, right: 10, bottom: 10 })
          Scroll() {
            Column() {
              ForEach(this.visibleProducts(), (item: Product) => {
                Row() {
                  Column() {
                    Text('GO').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#2367E8')
                    Text('DIGITAL').fontSize(9).fontColor('#667085')
                  }.width(76).height(76).justifyContent(FlexAlign.Center).backgroundColor('#EAF1FF').borderRadius(12)
                  Column() {
                    Text(item.name).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#222222')
                    Text(item.desc).fontSize(11).fontColor('#777777').margin({ top: 6 })
                    Text(item.price).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#E35A32').margin({ top: 8 })
                  }.alignItems(HorizontalAlign.Start).layoutWeight(1).margin({ left: 12 })
                  Text('查看').fontSize(12).fontColor('#2367E8')
                }.width('100%').padding(12).backgroundColor(Color.White).borderRadius(14).margin({ bottom: 10 })
                  .onClick(() => { this.openProduct(item); })
              }, (item: Product) => item.id.toString())
            }.padding({ left: 14, right: 14, bottom: 12 })
          }.layoutWeight(1)
          Row() {
            this.NavButton('商品', 'shop')
            this.NavButton('手势作业', 'gesture')
            this.NavButton('Preference', 'preference')
          }.width('100%').padding({ top: 10, bottom: 10 }).backgroundColor(Color.White)
        }.layoutWeight(1).backgroundColor('#F5F6F8')
      } else if (this.page === 'login') {
        Column() {
          Blank()
          Text('欢迎登录').fontSize(25).fontWeight(FontWeight.Bold).margin({ bottom: 30 })
          TextInput({ placeholder: '请输入用户名', text: this.username }).onChange((value: string) => { this.username = value; }).width('88%').height(50).backgroundColor('#F2F3F5').borderRadius(12)
          TextInput({ placeholder: '请输入密码', text: this.password }).type(InputType.Password).onChange((value: string) => { this.password = value; }).width('88%').height(50).backgroundColor('#F2F3F5').borderRadius(12).margin({ top: 14 })
          Button('登录').width('88%').height(48).backgroundColor('#2367E8').margin({ top: 26 }).onClick(() => {
            if (this.username.trim().length === 0 || this.password.length === 0) { this.showMessage('请填写用户名和密码'); }
            else { this.loggedIn = true; this.loginName = this.username.trim(); this.page = 'shop'; this.showMessage('登录成功'); }
          })
          Button('返回商品列表').width('88%').backgroundColor('#E9EDF5').fontColor('#333333').margin({ top: 12 }).onClick(() => { this.page = 'shop'; })
          Blank()
        }.width('100%').layoutWeight(1).alignItems(HorizontalAlign.Center).backgroundColor(Color.White)
      } else if (this.page === 'gesture') {
        Column() {
          Scroll() {
            Column() {
              Text('作业一：Gesture 手势').fontSize(21).fontWeight(FontWeight.Bold).margin({ bottom: 8 })
              Text('TapGesture：双击卡片放大/还原').fontSize(13).fontColor('#666666').margin({ bottom: 10 })
              Column() {
                Text('双击我').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2367E8')
                Text('TapGesture · 双击缩放').fontSize(12).fontColor('#667085').margin({ top: 8 })
              }.width('100%').height(150).justifyContent(FlexAlign.Center).backgroundColor('#EAF1FF').borderRadius(16).scale({ x: this.zoom, y: this.zoom })
                .gesture(TapGesture({ count: 2 }).onAction(() => { this.zoom = this.zoom === 1 ? 1.25 : 1; }))
              Text('PinchGesture：双指捏合调整下方区域大小').fontSize(13).fontColor('#666666').margin({ top: 22, bottom: 10 })
              Column() {
                Text(\`捏合缩放：\${this.pinchScale.toFixed(2)}x\`).fontSize(16).fontColor(Color.White)
              }.width('100%').height(100).justifyContent(FlexAlign.Center).backgroundColor('#536DFE').borderRadius(16).scale({ x: this.pinchScale, y: this.pinchScale })
                .gesture(PinchGesture().onActionUpdate((event: GestureEvent) => { this.pinchScale = Math.max(0.65, Math.min(1.6, event.scale)); }))
              Text('PanGesture：拖动控件').fontSize(13).fontColor('#666666').margin({ top: 22, bottom: 10 })
              Stack() {
                Text('拖动我').fontSize(14).fontColor(Color.White).padding(14).backgroundColor('#12A594').borderRadius(12)
                  .translate({ x: this.dragX, y: this.dragY })
                  .gesture(PanGesture().onActionUpdate((event: GestureEvent) => { this.dragX = Math.max(-100, Math.min(100, event.offsetX)); this.dragY = Math.max(-35, Math.min(35, event.offsetY)); }))
              }.width('100%').height(110).alignContent(Alignment.Center).backgroundColor('#F0F2F5').borderRadius(12)
              Text('PanGesture：列表左滑删除').fontSize(13).fontColor('#666666').margin({ top: 22, bottom: 10 })
              ForEach([0, 1, 2, 3, 4], (index: number) => {
                if (!this.deletedIds.includes(100 + index)) {
                  Row() {
                    Text(\`示例列表项 \${index + 1}\`).fontSize(14).layoutWeight(1)
                    Text('左滑删除').fontSize(12).fontColor('#E5484D')
                  }.width('100%').padding(16).backgroundColor(Color.White).borderRadius(10).margin({ bottom: 8 })
                    .translate({ x: this.swipeOffsets[index], y: 0 })
                    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
                      let offsets = this.swipeOffsets.slice(); offsets[index] = Math.min(0, Math.max(-140, event.offsetX)); this.swipeOffsets = offsets;
                    }).onActionEnd(() => {
                      if (this.swipeOffsets[index] < -80) { this.deletedIds = [...this.deletedIds, 100 + index]; this.showMessage('已删除列表项'); }
                      else { let offsets = this.swipeOffsets.slice(); offsets[index] = 0; this.swipeOffsets = offsets; }
                    }))
                }
              })
            }.padding(16)
          }.layoutWeight(1)
          Row() { this.NavButton('商品', 'shop'); this.NavButton('手势作业', 'gesture'); this.NavButton('Preference', 'preference'); }.width('100%').padding(10).backgroundColor(Color.White)
        }.layoutWeight(1).backgroundColor('#F5F6F8')
      } else {
        Column() {
          Scroll() {
            Column() {
              Text('作业三：Preference XML 存储').fontSize(21).fontWeight(FontWeight.Bold).margin({ bottom: 8 })
              Text('完成实例初始化、存储、读取、删除及数据落盘。').fontSize(13).fontColor('#666666').margin({ bottom: 18 })
              Text('键（Key）').fontSize(14).fontWeight(FontWeight.Medium).width('100%').margin({ bottom: 6 })
              TextInput({ placeholder: '例如 nickname', text: this.prefKey }).onChange((value: string) => { this.prefKey = value; }).width('100%').height(48).backgroundColor(Color.White).borderRadius(10)
              Text('值（Value）').fontSize(14).fontWeight(FontWeight.Medium).width('100%').margin({ top: 14, bottom: 6 })
              TextInput({ placeholder: '请输入要保存的值', text: this.prefValue }).onChange((value: string) => { this.prefValue = value; }).width('100%').height(48).backgroundColor(Color.White).borderRadius(10)
              Button('初始化 Preference').width('100%').margin({ top: 20 }).backgroundColor('#2367E8').onClick(() => { this.initPreferences(); })
              Row() {
                Button('存储 + 落盘').layoutWeight(1).backgroundColor('#2367E8').onClick(() => { this.savePreference(); })
                Button('读取').layoutWeight(1).backgroundColor('#526078').margin({ left: 8 }).onClick(() => { this.readPreference(); })
              }.width('100%').margin({ top: 10 })
              Button('删除 + 落盘').width('100%').backgroundColor('#D84B4B').margin({ top: 10 }).onClick(() => { this.deletePreference(); })
              Column() {
                Text('操作结果').fontSize(13).fontColor('#667085').width('100%')
                Text(this.prefOutput).fontSize(15).fontColor('#202632').width('100%').margin({ top: 8 })
              }.width('100%').padding(16).backgroundColor(Color.White).borderRadius(12).margin({ top: 18 })
              Text('说明：Preferences 为 HarmonyOS 的持久化键值存储，调用 flush() 将变更写入持久存储。').fontSize(12).fontColor('#777777').margin({ top: 14 })
            }.padding(16)
          }.layoutWeight(1)
          Row() { this.NavButton('商品', 'shop'); this.NavButton('手势作业', 'gesture'); this.NavButton('Preference', 'preference'); }.width('100%').padding(10).backgroundColor(Color.White)
        }.layoutWeight(1).backgroundColor('#F5F6F8')
      }
    }.width('100%').height('100%').backgroundColor(Color.White)
  }

  @Builder
  NavButton(label: string, target: string) {
    Column() {
      Text(label).fontSize(12).fontColor(this.page === target ? '#2367E8' : '#667085')
    }.layoutWeight(1).alignItems(HorizontalAlign.Center).padding(8).onClick(() => { this.page = target; })
  }
}
