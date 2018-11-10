package poly.util;
 
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
 
public class ReadCSV {
    public List<List<String>> getJsonParser(String filePath){
        //저장될 리스트
        List<List<String>> ret = new ArrayList<List<String>>();
        BufferedReader br = null;
        
        try{
            br = Files.newBufferedReader(Paths.get(filePath)); //리더 객체
            Charset.forName("UTF-8"); //문자 인코딩
            String line = ""; //한 줄을 읽을 변수
            int maxLimit = 10; //표시할 최대 행 변수
            
            //전부 읽어 내리거나 maxLimit만큼의 행까지만 반복
            while( (line = br.readLine()) != null && maxLimit > 0 ){
                
            	//CSV 1행을 저장하는 리스트
                List<String> tmpList = new ArrayList<String>();
                //쌍따옴표 제거
                line.replaceAll("\\\"", "");
                //System.out.println(line);
                
                String array[] = line.split(",");
                
                //배열에서 리스트 반환
                tmpList = Arrays.asList(array); 
                
                //최종 리스트에 배치
                ret.add(tmpList);
                maxLimit --; // 최대 제한 값 변수 감소
                
            }
        }catch(FileNotFoundException e){
            e.printStackTrace();
        }catch(IOException e){
            e.printStackTrace();
        }finally{
            try{
                if(br != null){
                    br.close();
                }
            }catch(IOException e){
                e.printStackTrace();
            }
        }
        return ret;
    }
}