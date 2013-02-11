package web.services;
import baza.client.ConnectToBD;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.ws.Endpoint;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Alex
 * Date: 31.12.12
 * Time: 0:20
 * To change this template use File | Settings | File Templates.
 */
@WebService()
@SOAPBinding(style = SOAPBinding.Style.DOCUMENT, use = SOAPBinding.Use.LITERAL)
public class WebServicesBaza {
  @WebMethod
  public String getTimeZone(Integer idKP) {
  return connector.getTimeZoneOnKP(idKP);
  }
  @WebMethod
  public void setLocateKP(String locate, String coordinate, String indetificate){
      connector.setLocate(locate,coordinate,indetificate);
  }
  @WebMethod
  public Date getTimeKP(Integer idKP){
      return connector.getTimeKP(idKP);
  }
  @WebMethod
  public Date getTimeCorrector(Integer idKP){
      return connector.getTimeCorrector(idKP);
  }
  @WebMethod
  public List<String> getAllCurrentValues(Integer idKP, Integer numberThreads){
      return connector.getAllCurrentValues(idKP,numberThreads);
  }
  @WebMethod
  public List<String> getHourArchive(Integer idKP,Integer numberThreads, Date begin, Date end){
      return connector.getHourArchive(idKP,numberThreads, begin,end);
  }
  @WebMethod
  public List<String> getAllDayArchive(Integer idKP,Integer numberThreads, Date begin, Date end){
      return connector.getAllDayArchive(idKP,numberThreads,begin,end);

  }
  @WebMethod
  public List<String> listOfEnterprise(){
     return connector.listOfEnterpise();
  }

 // public static void main(String[] argv) {
 //   Object implementor = new WebServicesBaza ();
 //   String address = "http://localhost:8080/WebServicesBaza";
 //   Endpoint.publish(address, implementor);
 // }

  private ConnectToBD connector = new ConnectToBD();
}