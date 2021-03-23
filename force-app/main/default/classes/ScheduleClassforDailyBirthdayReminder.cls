global class ScheduleClassforDailyBirthdayReminder implements Schedulable {
   
   global void execute(SchedulableContext sc) {
      Id batchjob= Database.executeBatch(new BatchClassSendingBODEmailReminderDaily(), 200);
   }
}