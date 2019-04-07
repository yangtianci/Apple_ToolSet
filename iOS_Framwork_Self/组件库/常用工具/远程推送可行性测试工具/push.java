import java.util.HashMap;
import java.util.Iterator;
import javapns.back.PushNotificationManager;
import javapns.back.SSLConnectionHelper;
import javapns.data.Device;
import javapns.data.PayLoad;

public class MainApnsSend {  
    public static void main(String[] args) throws Exception { 
       try {
              // token为不包含空格和<>的字母数字组合(字母不区分大小写)
              String deviceToken = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";    
              PushNotificationManager pushManager = PushNotificationManager.getInstance();
              pushManager.addDevice("iphone", deviceToken);
             
             // 苹果推送服务器 
             /*
             开发状态服务器地址 gateway.sandbox.push.apple.com 2195
             发布状态服务器地址 gateway.push.apple.com 2195
             
             需要注意：
             Xcode打出的Debug安装包只能选择开发服务器,证书可以选择开发推送证书或者发布推送证书；
             Xcode打出的AdHoc或Release安装包只能选择发布务器和发布推送证书；
             */
              String host= "gateway.sandbox.push.apple.com";
              // 端口号
              int port = 2195; 
              
              // 在mac系统下导出的p12证书(开发证书对应开发环境，发布证书对应所有环境)
              String certificatePath = "path/XXX.p12";  
              // p12证书密码
              String certificatePassword= "XXXX";
              // 初始化tcp连接                
              pushManager.initializeConnection(host, port, certificatePath, certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
                    
              // Send Push
              Device client = pushManager.getDevice("iphone");
              // 要推送的消息
              PayLoad payLoad = new PayLoad();
              payLoad.addAlert("测试我的push消息");
              payLoad.addBadge(1);
              payLoad.addSound("default");
              // 开始推送
              pushManager.sendNotification(client, payLoad);
              pushManager.stopConnection();
              pushManager.removeDevice("iphone");
             }
             catch (Exception e) {  
                 e.printStackTrace();
             }
             // else {
             //     System.out.println("push succeed!");
             // }
    }
}
