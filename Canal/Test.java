import java.net.InetSocketAddress;
import java.util.List;

import com.alibaba.otter.canal.client.CanalConnectors;
import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.common.utils.AddressUtils;
import com.alibaba.otter.canal.protocol.Message;
import com.alibaba.otter.canal.protocol.CanalEntry.Column;
import com.alibaba.otter.canal.protocol.CanalEntry.Entry;
import com.alibaba.otter.canal.protocol.CanalEntry.EntryType;
import com.alibaba.otter.canal.protocol.CanalEntry.EventType;
import com.alibaba.otter.canal.protocol.CanalEntry.RowChange;
import com.alibaba.otter.canal.protocol.CanalEntry.RowData;
import com.alibaba.otter.canal.protocol.Message;

import com.google.protobuf.ByteString;
import com.google.protobuf.InvalidProtocolBufferException;

public class Test
{
	public static void main(String[] args)
	{
		InetSocketAddress  isa = new InetSocketAddress("113.31.112.27",11111);
		//System.out.println(isa.getHostName());
		System.out.println( "InetSocketAddress." );

		// 创建链接
		CanalConnector connector = CanalConnectors.newSingleConnector(isa, "example", "canal", "canal");
		int batchSize = 1000;
		int emptyCount = 0;
		try {
			connector.connect();
			connector.subscribe(".*\\..*");
			connector.rollback();
			int totalEmptyCount = 120;
			while (emptyCount < totalEmptyCount) {
				Message message = connector.getWithoutAck(batchSize); // 获取指定数量的数据
				long batchId = message.getId();
				int size = message.getEntries().size();
				if (batchId == -1 || size == 0) {
					emptyCount++;
					System.out.println("empty count : " + emptyCount);
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
					}
				} else {
					emptyCount = 0;
					// System.out.printf("message[batchId=%s,size=%s] \n", batchId, size);
					printEntry(message.getEntries());
					//System.out.println(message.toString());
					showAllMessage(message);
				}

				connector.ack(batchId); // 提交确认
				// connector.rollback(batchId); // 处理失败, 回滚数据
			}

			System.out.println("empty too many times, exit");
		} finally {
			connector.disconnect();
		}
	}
	
	private static void printEntry(List<Entry> entrys) {
		for (Entry entry : entrys) {
			if (entry.getEntryType() == EntryType.TRANSACTIONBEGIN || entry.getEntryType() == EntryType.TRANSACTIONEND) {
				continue;
			}

			RowChange rowChage = null;
			try {
				rowChage = RowChange.parseFrom(entry.getStoreValue());
			} catch (Exception e) {
				throw new RuntimeException("ERROR ## parser of eromanga-event has an error , data:" + entry.toString(),
										   e);
			}

			EventType eventType = rowChage.getEventType();
			System.out.println(String.format("================&gt; binlog[%s:%s] , name[%s,%s] , eventType : %s",
											 entry.getHeader().getLogfileName(), entry.getHeader().getLogfileOffset(),
											 entry.getHeader().getSchemaName(), entry.getHeader().getTableName(),
											 eventType));
			System.out.println(entry.toString());
			

			for (RowData rowData : rowChage.getRowDatasList()) {
				if (eventType == EventType.DELETE) {
					printColumn(rowData.getBeforeColumnsList());
				} else if (eventType == EventType.INSERT) {
					printColumn(rowData.getAfterColumnsList());
				} else {
					System.out.println("-------&gt; before");
					printColumn(rowData.getBeforeColumnsList());
					System.out.println("-------&gt; after");
					printColumn(rowData.getAfterColumnsList());
				}
			}
		}
	}

	private static void printColumn(List<Column> columns) {
		for (Column column : columns) {
			System.out.println(column.getName() + " : " + column.getValue() + "    update=" + column.getUpdated());
		}
	}
	
	public static void showAllMessage(Message message)
	{
		List<Entry> entries = message.getEntries();
		for(Entry entry:entries)
		{
			
			ByteString storeValue = entry.getStoreValue();
			System.out.println("showAllMessage.");
			try {
				RowChange rowChage = RowChange.parseFrom(entry.getStoreValue());
				List<RowData> rowDatas = rowChage.getRowDatasList();
				
				System.out.println(rowDatas.toString());
				
			} catch (InvalidProtocolBufferException e) {
				e.printStackTrace();
			}
			
/* 			   Header header = entry.getHeader();
					header.getLogfileName();
					header.getLogfileOffset();
					header.getExecuteTime();
					header.getSchemaName();
					header.getEventType();
			   EntryType entryType = entry.getEntryType();
			   ByteString storeValue = entry.getStoreValue();
			   try {
				   RowChange rowChage = RowChange.parseFrom(entry.getStoreValue());
				   List<RowData> rowDatas = rowChage.getRowDatasList();
				   for(RowData rowData:rowDatas){
					   List<Column> afterColumns = rowData.getAfterColumnsList();//用于非delete操作
					   List<Column> beforeColumns = rowData.getBeforeColumnsList();//用于delete操作
					   for(Column afterColumn:afterColumns){
						   afterColumn.getIndex();
						   afterColumn.getMysqlType();
						   afterColumn.getName();
						   afterColumn.getIsKey();
						   afterColumn.getUpdated();
						   afterColumn.getIsNull();
						   afterColumn.getValue();
					   }
				   }
			   } catch (InvalidProtocolBufferException e) {
				   e.printStackTrace();
			   }
 */	 
		}
	}

}