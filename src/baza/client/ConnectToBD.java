package baza.client;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Alex
 * Date: 03.01.13
 * Time: 0:59
 * To change this template use File | Settings | File Templates.
 */
public class ConnectToBD {

    /**
     * Method sets the starting date, location and position KP.
     * method is called at the first CP Named to the database. Starting date KP are not required.
     * @param locate This Param set position (city, street and etc.)
     * @param coordinate set Coordinate KP
     */
    public void setLocate(String locate, String coordinate, String indetificate){
        Date data = new Date();
        data.setTime(new GregorianCalendar().getTime().getTime());
        try {
            PreparedStatement stmt = getConnection().prepareStatement("INSERT INTO locate(locate, locateCoordinate) values(?,?); select locate.idlocate from locate where locate.locate=?");
            try{
            stmt.setString(1,locate);
            stmt.setString(2, coordinate);
            stmt.setString(3,locate);
            ResultSet rst = stmt.executeQuery();      // уточнить момент с executeQuery
            int idLocate = rst.getInt(1);
            stmt = getConnection().prepareStatement("insert into kp(locate_idlocate, indeteficate, dateBegin) values(?,?,?)");
            stmt.setInt(1,idLocate);
            stmt.setString(2, indetificate);
            stmt.setDate(3, (java.sql.Date) data);
            stmt.executeQuery();
            stmt.close();
        }
            finally {
                stmt.close();
            }
            }
            catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    /**
     * Method get Time Zone on host KP
     * @param idKP
     * @return String time zone
     */
    public String getTimeZoneOnKP(Integer idKP){
        String timezone = null;
        try {
            PreparedStatement stmt = getConnection().prepareStatement("Select timeparametrs.timeZone from timeparametrs where kp_idkp = ?");
            try{
            stmt.setInt(1, idKP);
            ResultSet rst = stmt.executeQuery();
            timezone = rst.getString(1);

        }
            finally {
                stmt.close();
            }
            }
            catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return timezone;
    }

    /**
     * Method return time on KP
     * @param idKP
     * @return Date
     */
     public Date getTimeKP(Integer idKP){
         Date data = new Date();

         try {
             PreparedStatement state = getConnection().prepareStatement("SELECT timeparametrs.timeHost from timeparametrs where kp_idkp = ?");
             try{
             state.setInt(1, idKP);
             ResultSet rst = state.executeQuery();
             data= rst.getDate(1);

         }
             finally {
              state.close();
             }
             }
             catch (SQLException e) {
             e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
         }
         return data;
     }

    /**
     * Method get Time on correktor
     * @param idKP
     * @return date
     */
    public Date getTimeCorrector(Integer idKP){
        Date data = new Date();
        try {
            PreparedStatement state = getConnection().prepareStatement("select timeparametrs.timeCorrektor from timeparametrs where timeparametrs.kp_idkp=?");
            try{

            state.setInt(1,idKP);
            ResultSet rst = state.executeQuery();
            data= rst.getDate(1);
        }
        finally {
            state.close();
        }}
        catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return data;
    }

    /**
     * request current parametrs
     * @param idKP
     * @return currenttime,currentworkvolume, currentnormalvolume, currentworkconsum, currentnormalconsum, currentpressure, currenttemper in List
     */
    public List<String> getAllCurrentValues(Integer idKP, Integer nomerNitki){
        List<String> current= new ArrayList<String>();

            try {
                PreparedStatement state = getConnection().prepareStatement("SELECT currenttime,currentworkvolume, currentnormalvolume, currentworkconsum, currentnormalconsum, currentpressure, currenttemper FROM currentvalues WHERE idCurrentOptions=(SELECT MAX(idCurrentOptions) FROM currentvalues WHERE Nitka=? AND kp_idkp=?)");
                try{
                    state.setInt(1,nomerNitki);
                    state.setInt(2,idKP);
                    ResultSet rst = state.executeQuery();
                    while (rst.next()){
                        for (int i=1; i<=7; i++){
                            current.add(rst.getString(i));
                        }
                    }
                }finally {
                    state.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }

        return current;
    }
    //по желанию можно добавить какие-нибудь отдельно запрашиваемые параметры (надо ли?)

    /**
     * method return all hourly archive. format date YYYY-MM-DD HH:MM:SS
     * @param idKP
     * @param begin date
     * @param end date
     * @return  hourlydatebegin, hourlydateend, hourlyworkvolume, hourlynormalvolume, HourlyTemper, HourlyPressure
     */
    public List<String> getHourArchive(Integer idKP, Integer nomerNitka, Date begin, Date end){
        List<String> hourArchive = new ArrayList<String>();
        try {
            PreparedStatement state = getConnection().prepareStatement("select hourlydatebegin, hourlydateend, hourlyworkvolume, hourlynormalvolume, HourlyTemper, HourlyPressure from hourlyarchive where HourlyDateEnd=? and HourlyDateBegin =? and Nitka=? AND kp_idkp=?");
            try{
                state.setDate(1, (java.sql.Date) end);        //посмотреть на правильность выполнения!
                state.setDate(2, (java.sql.Date) begin);
                state.setInt(3,nomerNitka);
                state.setInt(4, idKP);
                ResultSet  rst = state.executeQuery();
                while(rst.next()){
                    for (int i=1; i<=6; i++){
                        hourArchive.add(rst.getString(i));
                    }
                }
            }
            finally {
                state.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return hourArchive;
    }

    /**
     * return All Day Archive
     * @param idKP
     * @param begin
     * @param end
     * @return collection with DayDateBegin,DayDateEnd, DayWorkVolume, DayNormalValue, DayTemper, DayPressure
     */
    public List<String> getAllDayArchive(Integer idKP,Integer nomerNitki, Date begin, Date end){
        List<String> dayArchive = new ArrayList<String>();
        try {
            PreparedStatement state = getConnection().prepareStatement("select DayDateBegin,DayDateEnd, DayWorkVolume, DayNormalValue, DayTemper, DayPressure from dayarchive where DayDateEnd=? and DayDateBegin =? and Nitka=? and kp_idkp=?");
            try{
                state.setDate(1, (java.sql.Date) end);        //посмотреть на правильность выполнения!
                state.setDate(2, (java.sql.Date) begin);
                state.setInt(3,nomerNitki);
                state.setInt(4, idKP);
                ResultSet  rst = state.executeQuery();
                while(rst.next()){
                    for (int i=1; i<=6; i++){
                        dayArchive.add(rst.getString(i));
                    }
                }
            }
            finally {
                state.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return dayArchive;
    }
    public List<String> listOfEnterpise(){
        List<String> enter=new ArrayList<String>();
        try {
            PreparedStatement state = getConnection().prepareStatement("select location from location");
            try{

                ResultSet  rst = state.executeQuery();
                while(rst.next()){
                    for (int i=1; i<=6; i++){
                        enter.add(rst.getString(i));
                    }
                }
            }
            finally {
                state.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return enter;
    }



    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/telemetria?useUnicode=true&characterEncoding=utf8";
        String username = "usr_tlm";
        String password = "telemetria";
        return DriverManager.getConnection(url, username, password);
        }
}
