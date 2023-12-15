package com.outSouPlat.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.net.ftp.*;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 文件上传工具�?
 *
 * @author lenovo
 */
public class FileUtil {

	private static Class<? extends Object> cls = FileUtil.class;
	
	/**
	 * 本地
	 */
	public static final int LOCAL=1;
	/**
	 * 网络
	 */
	public static final int REMOTE=2;
	
	/**
	 * 代码
	 */
	public static final int CODE=1;
	/**
	 * 附件
	 */
	public static final int ANNEX=2;

	//资讯内容上传的文件(by 石超)
	public static String appUploadContentImg(MultipartFile myFile, String folder) throws Exception {
		try {
			//重置文件名
			//long time = System.currentTimeMillis();
			//String timeStr = String.valueOf(time);
			String time = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			folder+="/"+time.substring(0, 4);
			String[] originalFileName = myFile.getOriginalFilename().split("\\.");
			String fileName = time + "." + originalFileName[1];
			String avaPath ="/OutSouPlat/upload/"+folder+"/"+fileName;
			String realPath="D:\\resource\\OutSouPlat\\"+folder+"\\";
			System.out.println(avaPath);
			File storeFile =  new File(realPath, fileName);
			FileUtils.copyInputStreamToFile(myFile.getInputStream(),storeFile );
			
			JSONObject map = new JSONObject();
			map.put("code", 0);
			map.put("msg", "成功");
			JSONObject js = new JSONObject();
			js.put("src", avaPath);
			map.put("data", js);
			return map.toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("");
		}
	}
	
	public static void delete(String fileUrls) {
		String[] fileUrlArr = fileUrls.split(",");
		for (int i = 0; i < fileUrlArr.length; i++) {
			String fileUrl = fileUrlArr[i];
			File file = new File("D:\\resource"+fileUrl.replaceAll("OutSouPlat/upload", "OutSouPlat"));
			if(file.exists()) {
				file.delete();
			}
		}
	}
	

	//获取ftp连接成功对象，连接失败则抛出异常
	public static FTPClient getFTPClient(String ftpHost, Integer ftpPort, String userName, String password) throws Exception {
		try {
			//创建ftp对象
			FTPClient ftpClient = new FTPClient();
			int port = ftpPort == null ? 21 : ftpPort;
			//传入主机和端口建立连�?
			ftpClient.connect(ftpHost, port);
			//用户名�?�密码登�?
			ftpClient.login(userName, password);
			;
			if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				ftpClient.disconnect();
				throw new Exception(ftpClient.getReplyString());
			}
			return ftpClient;
		} catch (SocketException e1) {
			throw new SocketException(e1.getMessage());
		} catch (IOException e2) {
			throw new IOException(e2.getMessage());
		} catch (Exception e3) {
			throw new Exception(e3.getMessage());
		}
	}

	//读取ftp服务器上文件方法
	public static String readFileForFTP(FTPClient ftpClient, String ftpPath, String fileName) {
		StringBuffer resultBuffer = new StringBuffer();
		FileInputStream inFile = null;
		InputStream in = null;
		try {
			//设置编码
			ftpClient.setControlEncoding("UTF-8");
			//文件类型
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			//
			ftpClient.enterLocalPassiveMode();
			//改变访问的ftp服务器目�?
			ftpClient.changeWorkingDirectory(ftpPath);
			//根据当前文件下的文件名接收文�?
			in = ftpClient.retrieveFileStream(fileName);
		} catch (FileNotFoundException e1) {
			return "下载配置文件失败，请联系管理�?.";
		} catch (SocketException e2) {
		} catch (IOException e3) {
			return "配置文件读取失败，请联系管理�?.";
		}
		//处理接收到的输入�?
		if (in != null) {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
			String data = null;
			try {
				while ((data = bufferedReader.readLine()) != null) {
					resultBuffer.append(data).append("\n");
				}
			} catch (IOException e1) {
			} finally {
				try {
					ftpClient.disconnect();
				} catch (IOException e) {
				}
			}
		} else {
			return null;
		}
		return resultBuffer.toString();
	}


	//上传至ftp服务器文件方�?
	public static void uploadFileForFTP(FTPClient ftpClient, String ftpFileName, String writeTempFilePath, String operatePath) throws Exception {
		try {
			//设置passiveMode传输
			ftpClient.enterLocalPassiveMode();
			//设置传输方式
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			//对远程目录的处理
			String remoteFileName = ftpFileName;
			//改变操作目录
			ftpClient.changeWorkingDirectory(operatePath);
			//本地写入成功
			File file = new File(writeTempFilePath);
			InputStream in = new FileInputStream(file);
			ftpClient.storeFile(remoteFileName, in);
			in.close();
			file.delete();
			return;
		} catch (Exception e) {
			ftpClient.disconnect();
			throw new Exception("上传图片到服务器失败");
		} finally {
			try {
				ftpClient.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	//https://blog.csdn.net/m0_59800431/article/details/129662276
	@RequestMapping(value="/downloadLocal")
	public static void downloadLocal(HttpServletRequest request, HttpServletResponse response) {
		try {
			//1.要获取下载文件的路径
			String realPath = "D:/resource/OutSouPlat/TaskBag/annex/1695712914708.txt";
			System.out.println("下载文件的路径："+realPath);
			//2.下载的文件名是什么？
			String filename = realPath.substring(realPath.lastIndexOf("/") + 1);
			//3.设置想办法让浏览器能够支持下载我们需要的东西
			response.setHeader("Content-Disposition","attachment;filename="+filename);
			//4.获取下载文件的输入流
			FileInputStream in = new FileInputStream(realPath);
			//5.创建缓冲区
			int len=0;
			byte[] buffer = new byte[1024];
			//6.获取OutputStream对象
			ServletOutputStream out = response.getOutputStream();
			//7.将FileOutputStream流写入到buffer缓冲区,使用OutputStream将缓冲区中的数据输出到客户端
			while((len=in.read(buffer))>0) {
			    out.write(buffer,0,len);
			}
			in.close();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/downloadRemote")
	public static void downloadRemote(HttpServletRequest request, HttpServletResponse response) {
		try {
			//1.要获取下载文件的路径
			//String realPath = "http://192.168.1.102:8080//OutSouPlat//upload//TaskBag//annex//3H3fcrenzheshengui3wudiban.rar";
			String realPath = request.getParameter("realPath").replaceAll("/", "//");
			System.out.println("下载文件的路径："+realPath);
			//2.下载的文件名是什么？
			String filename = realPath.substring(realPath.lastIndexOf("//") + 2);
			//3.设置想办法让浏览器能够支持下载我们需要的东西
			response.setHeader("Content-Disposition","attachment;filename="+filename);
			//4.获取下载文件的输入流
			URL url = new URL(realPath);
			URLConnection conn = url.openConnection();
			InputStream in = conn.getInputStream();
			//5.创建缓冲区
			int len=0;
			byte[] buffer = new byte[1024];
			//6.获取OutputStream对象
			ServletOutputStream out = response.getOutputStream();
			//7.将FileOutputStream流写入到buffer缓冲区,使用OutputStream将缓冲区中的数据输出到客户端
			while((len=in.read(buffer))>0) {
			    out.write(buffer,0,len);
			}
			in.close();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String getRootDirectory() {
		return "http://120.27.5.36:8500/";
	}


}