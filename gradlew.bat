package com.yoohoo.android.laundry.ui.activity;

import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yoohoo.android.laundry.Parameter;
import com.yoohoo.android.laundry.R;
import com.yoohoo.android.laundry.base.BaseActivity;
import com.yoohoo.android.laundry.bean.EmployeeInfoBean;
import com.yoohoo.android.laundry.bean.HttpBean;
import com.yoohoo.android.laundry.bean.Params;
import com.yoohoo.android.laundry.interfaces.OkResponseInterface;
import com.yoohoo.android.laundry.net.OkhttpUtil;
import com.yoohoo.android.laundry.util.VoiceManager;
import com.yoohoo.android.laundry.utils.EPCEntity;
import com.yoohoo.android.laundry.utils.EPCUtils;

import java.util.ArrayList;
import java.util.List;

import invengo.javaapi.core.BaseReader;
import invengo.javaapi.core.IMessageNotification;
import invengo.javaapi.core.Util;
import invengo.javaapi.handle.IMessageNotificationReceivedHandle;
import invengo.javaapi.protocol.IRP1.RXD_TagData;

public class ActivityQuery extends BaseActivity implements IMessageNotificationReceivedHandle, View.OnClickListener {


    private LinearLayout mLinearLayout;
    private EditText action_search_profile;
    private List<EPCEntity> mEPCEntityList = new ArrayList<EPCEntity>();
    private static final int GET_EPC_AC = 3 << 6;
    private boolean isRead = true;
    private ImageView search;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case GET_EPC_AC:

                    EPCUtils.getInstance().getStop();
                    List<EPCEntity> list = (List<EPCEntity>) msg.obj;
                    if (list != null && list.size() > 0) {
                        EPCEntity epcEntity = list.get(0);
                        String tid = epcEntity.getEpcData();
//                        soundPlayer.play();
                        VoiceManager.getInsta