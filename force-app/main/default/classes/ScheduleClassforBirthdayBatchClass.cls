global class ScheduleClassforBirthdayBatchClass implements Schedulable {
   global void execute(SchedulableContext sc) {
      Id batchjob= Database.executeBatch(new BatchClassSendingBODEmailReminder(), 200);

   }

}