<template>
    <div class="row contenedor_md">
        <div class="col-md-12">
            <form>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.codigo,
                            }"
                            >Código*</label
                        >
                        <el-input
                            placeholder="Código"
                            :class="{
                                'is-invalid': errors.codigo,
                            }"
                            v-model="oModeloDeterministico.codigo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.codigo"
                            v-text="errors.codigo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.nombre,
                            }"
                            >Nombre*</label
                        >
                        <el-input
                            placeholder="Nombre"
                            :class="{
                                'is-invalid': errors.nombre,
                            }"
                            v-model="oModeloDeterministico.nombre"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.nombre"
                            v-text="errors.nombre[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.descripcion,
                            }"
                            >Descripción</label
                        >
                        <el-input
                            type="textarea"
                            autosize
                            placeholder="Descripción"
                            :class="{
                                'is-invalid': errors.descripcion,
                            }"
                            v-model="oModeloDeterministico.descripcion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.descripcion"
                            v-text="errors.descripcion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.repuesto_id,
                            }"
                            >Seleccionar Repuesto*</label
                        >

                        <el-select
                            class="w-100"
                            :class="{
                                'is-invalid': errors.repuesto_id,
                            }"
                            v-model="oModeloDeterministico.repuesto_id"
                            filterable
                            placeholder="Repuesto/Equipo de protección"
                            @change="getRepuesto()"
                        >
                            <el-option
                                v-for="item in listRepuestos"
                                :key="item.id"
                                :value="item.id"
                                :label="
                                    item.codigo +
                                    ' | ' +
                                    item.nombre +
                                    ' | ' +
                                    item.descripcion
                                "
                            >
                            </el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.repuesto_id"
                            v-text="errors.repuesto_id[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            COSTO POR ORDENAR
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.sm,
                            }"
                            >Salario Mensual</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.sm,
                            }"
                            v-model="oModeloDeterministico.sm"
                            @change="
                                calculaCPO();
                                calculaCGI();
                            "
                            @keyup="
                                calculaCPO();
                                calculaCGI();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.sm"
                            v-text="errors.sm[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.it,
                            }"
                            >Inversión de Tiempo/Hora</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.it,
                            }"
                            v-model="oModeloDeterministico.it"
                            @change="
                                calculaCPO();
                                calculaCGI();
                            "
                            @keyup="
                                calculaCPO();
                                calculaCGI();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.it"
                            v-text="errors.it[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.cpo,
                            }"
                            >Costo de Procesamiento de la Orden
                            <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.cpo,
                            }"
                            v-model="oModeloDeterministico.cpo"
                            clearable
                            readonly
                            @change="calculaCostoOrdenar"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.cpo"
                            v-text="errors.cpo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.ct_ordenar,
                            }"
                            >Costo de Transporte por Ordenar</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.ct_ordenar,
                            }"
                            v-model="oModeloDeterministico.ct_ordenar"
                            clearable
                            @change="calculaCostoOrdenar"
                            @keyup="calculaCostoOrdenar"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ct_ordenar"
                            v-text="errors.ct_ordenar[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_ins,
                            }"
                            >Costo de Inspección</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_ins,
                            }"
                            v-model="oModeloDeterministico.c_ins"
                            clearable
                            @change="calculaCostoOrdenar"
                            @keyup="calculaCostoOrdenar"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_ins"
                            v-text="errors.c_ins[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_em,
                            }"
                            >Costo de Empaquetado</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_em,
                            }"
                            v-model="oModeloDeterministico.c_em"
                            clearable
                            @change="calculaCostoOrdenar"
                            @keyup="calculaCostoOrdenar"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_em"
                            v-text="errors.c_em[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_ordenar,
                            }"
                            >Costo por Ordenar <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_ordenar,
                            }"
                            v-model="oModeloDeterministico.c_ordenar"
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_ordenar"
                            v-text="errors.c_ordenar[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            COSTO POR ADQUISICIÓN
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.precio_compra,
                            }"
                            >Precio de Compra</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.precio_compra,
                            }"
                            v-model="oModeloDeterministico.precio_compra"
                            @change="
                                calculaCostoAdquisicion();
                                calculaCostoDepreciacion();
                            "
                            @keyup="
                                calculaCostoAdquisicion();
                                calculaCostoDepreciacion();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.precio_compra"
                            v-text="errors.precio_compra[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.ct_adqui,
                            }"
                            >Costos de Transporte por Adqiusición</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.ct_adqui,
                            }"
                            v-model="oModeloDeterministico.ct_adqui"
                            @change="calculaCostoAdquisicion"
                            @keyup="calculaCostoAdquisicion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ct_adqui"
                            v-text="errors.ct_adqui[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_impor,
                            }"
                            >Costos de Importación</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_impor,
                            }"
                            v-model="oModeloDeterministico.c_impor"
                            @change="calculaCostoAdquisicion"
                            @keyup="calculaCostoAdquisicion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_impor"
                            v-text="errors.c_impor[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_alma_ext,
                            }"
                            >Costos de Almacenamiento Externo</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_alma_ext,
                            }"
                            v-model="oModeloDeterministico.c_alma_ext"
                            @change="calculaCostoAdquisicion"
                            @keyup="calculaCostoAdquisicion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_alma_ext"
                            v-text="errors.c_alma_ext[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.oc_adqui,
                            }"
                            >Otros Costos por Adquisición</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.oc_adqui,
                            }"
                            v-model="oModeloDeterministico.oc_adqui"
                            @change="calculaCostoAdquisicion"
                            @keyup="calculaCostoAdquisicion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.oc_adqui"
                            v-text="errors.oc_adqui[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_adqui,
                            }"
                            >Costo por Adquisición <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_adqui,
                            }"
                            v-model="oModeloDeterministico.c_adqui"
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_adqui"
                            v-text="errors.c_adqui[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            COSTOS DE MANTENIMIENTO
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_alqui,
                            }"
                            >Costo de Alquiler de Espacio</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_alqui,
                            }"
                            v-model="oModeloDeterministico.c_alqui"
                            @change="
                                calculaCostoEspacio();
                                calculaCostoTotalMantenimiento();
                            "
                            @keyup="
                                calculaCostoEspacio();
                                calculaCostoTotalMantenimiento();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_alqui"
                            v-text="errors.c_alqui[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.area_ocupada,
                            }"
                            >Área Ocupada</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.area_ocupada,
                            }"
                            v-model="oModeloDeterministico.area_ocupada"
                            @change="
                                calculaCostoEspacio();
                                calculaCostoTotalMantenimiento();
                            "
                            @keyup="
                                calculaCostoEspacio();
                                calculaCostoTotalMantenimiento();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.area_ocupada"
                            v-text="errors.area_ocupada[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_espa,
                            }"
                            >Costo del Espacio <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_espa,
                            }"
                            v-model="oModeloDeterministico.c_espa"
                            readonly
                            @change="calculaCostoTotalMantenimiento"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_espa"
                            v-text="errors.c_espa[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.vp_rep,
                            }"
                            >Valor Promedio de Repuestos</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.vp_rep,
                            }"
                            v-model="oModeloDeterministico.vp_rep"
                            clearable
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.vp_rep"
                            v-text="errors.vp_rep[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.cantp_rep,
                            }"
                            >Cantidad Promedio de Repuestos</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.cantp_rep,
                            }"
                            v-model="oModeloDeterministico.cantp_rep"
                            clearable
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.cantp_rep"
                            v-text="errors.cantp_rep[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.costop_rep,
                            }"
                            >Costo Promedio de Repuestos</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.costop_rep,
                            }"
                            v-model="oModeloDeterministico.costop_rep"
                            @change="calculaCostoCapital"
                            @keyup="calculaCostoCapital"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.costop_rep"
                            v-text="errors.costop_rep[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.tasa_ia,
                            }"
                            >Tasa de Interés Anual:
                            <span
                                v-text="oModeloDeterministico.tasa_ia_calculado"
                            ></span
                        ></label>
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.tasa_ia,
                            }"
                            v-model="oModeloDeterministico.tasa_ia"
                            @change="
                                calculaTasaIA();
                                calculaCostoTotalMantenimiento();
                            "
                            @keyup="
                                calculaTasaIA();
                                calculaCostoTotalMantenimiento();
                            "
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.tasa_ia"
                            v-text="errors.tasa_ia[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.costo_capital,
                            }"
                            >Costo de Capital <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.costo_capital,
                            }"
                            v-model="oModeloDeterministico.costo_capital"
                            readonly
                            @change="calculaCostoTotalMantenimiento"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.costo_capital"
                            v-text="errors.costo_capital[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.ct_almacenamiento,
                            }"
                            >Costo Total de Almacenamiento
                            <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.ct_almacenamiento,
                            }"
                            v-model="oModeloDeterministico.ct_almacenamiento"
                            readonly
                            @change="calculaCostoMantenimiento"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ct_almacenamiento"
                            v-text="errors.ct_almacenamiento[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_depreciacion,
                            }"
                            >Costo de Depreciación <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_depreciacion,
                            }"
                            v-model="oModeloDeterministico.c_depreciacion"
                            @change="calculaCostoMantenimiento"
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_depreciacion"
                            v-text="errors.c_depreciacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_gi,
                            }"
                            >Costo de Gestión de Inventario
                            <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_gi,
                            }"
                            v-model="oModeloDeterministico.c_gi"
                            readonly
                            @change="calculaCostoMantenimiento"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_gi"
                            v-text="errors.c_gi[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.oc_mantenimiento,
                            }"
                            >Otros Costos de Mantenimiento</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.oc_mantenimiento,
                            }"
                            v-model="oModeloDeterministico.oc_mantenimiento"
                            @change="calculaCostoMantenimiento"
                            @keyup="calculaCostoMantenimiento"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.oc_mantenimiento"
                            v-text="errors.oc_mantenimiento[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.c_mantenimiento,
                            }"
                            >Costo de Mantenimiento <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.c_mantenimiento,
                            }"
                            v-model="oModeloDeterministico.c_mantenimiento"
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.c_mantenimiento"
                            v-text="errors.c_mantenimiento[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.procesamiento_pedido,
                            }"
                            >Procesamiento del Periodo en Horas:
                            <span
                                v-text="
                                    oModeloDeterministico.procesamiento_pedido_calculado
                                "
                            ></span
                        ></label>
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.procesamiento_pedido,
                            }"
                            v-model="oModeloDeterministico.procesamiento_pedido"
                            @keyup="calculaProcesamientoPedido"
                            @change="calculaProcesamientoPedido"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.procesamiento_pedido"
                            v-text="errors.procesamiento_pedido[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.fabricacion_productos,
                            }"
                            >Fabricación Producción Días</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.fabricacion_productos,
                            }"
                            v-model="
                                oModeloDeterministico.fabricacion_productos
                            "
                            @change="calculaLeadtime"
                            @keyup="calculaLeadtime"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fabricacion_productos"
                            v-text="errors.fabricacion_productos[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.tiempo_transito,
                            }"
                            >Tiempo de Transito Días</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.tiempo_transito,
                            }"
                            v-model="oModeloDeterministico.tiempo_transito"
                            @change="calculaLeadtime"
                            @keyup="calculaLeadtime"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.tiempo_transito"
                            v-text="errors.tiempo_transito[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.inspeccion_control,
                            }"
                            >Inspección y Control Días</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.inspeccion_control,
                            }"
                            v-model="oModeloDeterministico.inspeccion_control"
                            @change="calculaLeadtime"
                            @keyup="calculaLeadtime"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.inspeccion_control"
                            v-text="errors.inspeccion_control[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.unidad,
                            }"
                            >Unidad de Tiempo</label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.unidad,
                            }"
                            v-model="oModeloDeterministico.unidad"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.unidad"
                            v-text="errors.unidad[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-4">
                        <label
                            :class="{
                                'text-danger': errors.leadtime,
                            }"
                            >LEAD TIME <i>(automático)</i></label
                        >
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.leadtime,
                            }"
                            v-model="oModeloDeterministico.leadtime"
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.leadtime"
                            v-text="errors.leadtime[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <el-button
                            type="primary"
                            class="bg-primary"
                            :loading="enviando"
                            @click="setRegistro()"
                            >{{ textoBoton }}</el-button
                        >
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        modelo_deterministico: {
            type: Object,
            default: {
                id: 0,
                codigo: "",
                nombre: "",
                descripcion: "",
                repuesto_id: "",
                sm: "",
                it: "",
                cpo: "",
                ct_ordenar: "",
                c_ins: "",
                c_em: "",
                c_ordenar: "",
                precio_compra: "",
                ct_adqui: "",
                c_impor: "",
                c_alma_ext: "",
                oc_adqui: "",
                c_adqui: "",
                c_alqui: "",
                area_ocupada: "",
                c_espa: "",
                vp_rep: "",
                cantp_rep: "",
                costop_rep: "",
                tasa_ia: "",
                costo_capital: "",
                ct_almacenamiento: "",
                c_depreciacion: "",
                c_gi: "",
                oc_mantenimiento: "",
                c_mantenimiento: "",
                leadtime: "",
                procesamiento_pedido: "",
                procesamiento_pedido_calculado: "",
                fabricacion_productos: "",
                tiempo_transito: "",
                inspeccion_control: "",
                unidad: 12,
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
        modelo_deterministico(newVal) {
            this.oModeloDeterministico = newVal;
        },
    },
    computed: {
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oRepuesto: null,
            oModeloDeterministico: this.modelo_deterministico,
            listRepuestos: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getRepuestos();
        this.getPromedioRepuestos();
    },
    methods: {
        getRepuesto() {
            if (this.oModeloDeterministico.repuesto_id != "") {
                axios
                    .get(
                        "/admin/repuestos/" +
                            this.oModeloDeterministico.repuesto_id
                    )
                    .then((response) => {
                        this.oRepuesto = response.data.repuesto;
                        console.log(this.oRepuesto);
                        this.calculaCostoDepreciacion();
                    });
            } else {
                this.oRepuesto = null;
            }
        },
        getRepuestos() {
            axios.get("/admin/repuestos").then((response) => {
                this.listRepuestos = response.data.repuestos;
            });
        },
        calculaCPO() {
            try {
                this.oModeloDeterministico.cpo =
                    parseFloat(this.oModeloDeterministico.sm) *
                    (parseFloat(this.oModeloDeterministico.it) / 2160);
                this.oModeloDeterministico.cpo = parseFloat(
                    this.oModeloDeterministico.cpo
                ).toFixed(2);
            } catch (e) {
                console.log("Error al calcular CPO");
                console.log(e);
                this.oModeloDeterministico.cpo = "";
            }
        },
        calculaCGI() {
            try {
                this.oModeloDeterministico.c_gi =
                    parseFloat(this.oModeloDeterministico.sm) *
                    (parseFloat(this.oModeloDeterministico.it) / 2160);
                this.oModeloDeterministico.c_gi = parseFloat(
                    this.oModeloDeterministico.c_gi
                ).toFixed(2);
                this.calculaCostoMantenimiento();
            } catch (e) {
                console.log("Error al calcular CGI");
                console.log(e);
                this.oModeloDeterministico.c_gi = "";
            }
        },
        calculaCostoOrdenar() {
            try {
                this.oModeloDeterministico.c_ordenar =
                    parseFloat(this.oModeloDeterministico.cpo) +
                    parseFloat(this.oModeloDeterministico.ct_ordenar) +
                    parseFloat(this.oModeloDeterministico.c_ins) +
                    parseFloat(this.oModeloDeterministico.c_em);
                this.oModeloDeterministico.c_ordenar = parseFloat(
                    this.oModeloDeterministico.c_ordenar
                ).toFixed(2);
            } catch (e) {
                this.oModeloDeterministico.c_ordenar = "";
            }
        },
        calculaCostoAdquisicion() {
            try {
                this.oModeloDeterministico.c_adqui =
                    parseFloat(this.oModeloDeterministico.precio_compra) +
                    parseFloat(this.oModeloDeterministico.ct_adqui) +
                    parseFloat(this.oModeloDeterministico.c_impor) +
                    parseFloat(this.oModeloDeterministico.c_alma_ext) +
                    parseFloat(this.oModeloDeterministico.oc_adqui);
                this.oModeloDeterministico.c_adqui = parseFloat(
                    this.oModeloDeterministico.c_adqui
                ).toFixed(2);
            } catch (e) {
                this.oModeloDeterministico.c_adqui = "";
            }
        },
        calculaCostoEspacio() {
            try {
                this.oModeloDeterministico.c_espa =
                    parseFloat(this.oModeloDeterministico.c_alqui) *
                    parseFloat(this.oModeloDeterministico.area_ocupada);
                this.oModeloDeterministico.c_espa = parseFloat(
                    this.oModeloDeterministico.c_espa
                );
            } catch (e) {
                this.oModeloDeterministico.c_mantenimiento = "";
            }
        },
        calculaTasaIA() {
            try {
                if (
                    this.oModeloDeterministico.tasa_ia == "" ||
                    isNaN(this.oModeloDeterministico.tasa_ia)
                ) {
                    throw new Error(
                        "El valor de tasa_ia no es un número válido"
                    );
                }
                this.oModeloDeterministico.tasa_ia_calculado = parseFloat(
                    parseFloat(this.oModeloDeterministico.tasa_ia) / 400
                ).toFixed(2);
                this.calculaCostoCapital();
            } catch (e) {
                this.oModeloDeterministico.tasa_ia_calculado = "";
                this.oModeloDeterministico.costo_capital = "";
            }
        },
        calculaCostoCapital() {
            try {
                if (
                    this.oModeloDeterministico.costop_rep == "" ||
                    isNaN(parseFloat(this.oModeloDeterministico.costop_rep)) ||
                    this.oModeloDeterministico.tasa_ia_calculado == "" ||
                    isNaN(
                        parseFloat(this.oModeloDeterministico.tasa_ia_calculado)
                    )
                ) {
                    throw new Error("El valor obtenido es no númerico");
                }

                this.oModeloDeterministico.costo_capital =
                    parseFloat(this.oModeloDeterministico.costop_rep) *
                    parseFloat(this.oModeloDeterministico.tasa_ia_calculado);
                this.oModeloDeterministico.costo_capital = parseFloat(
                    this.oModeloDeterministico.costo_capital
                ).toFixed(2);
            } catch (e) {
                this.oModeloDeterministico.costo_capital = "";
            }
        },
        calculaCostoMantenimiento() {
            try {
                this.oModeloDeterministico.c_mantenimiento =
                    parseFloat(this.oModeloDeterministico.ct_almacenamiento) +
                    parseFloat(this.oModeloDeterministico.c_depreciacion) +
                    parseFloat(this.oModeloDeterministico.c_gi) +
                    parseFloat(this.oModeloDeterministico.oc_mantenimiento);
                this.oModeloDeterministico.c_mantenimiento = parseFloat(
                    this.oModeloDeterministico.c_mantenimiento
                ).toFixed(2);
            } catch (e) {
                this.oModeloDeterministico.c_mantenimiento = "";
            }
        },
        calculaCostoTotalMantenimiento() {
            try {
                this.oModeloDeterministico.ct_almacenamiento =
                    parseFloat(this.oModeloDeterministico.c_espa) +
                    parseFloat(this.oModeloDeterministico.costo_capital);
                this.oModeloDeterministico.ct_almacenamiento = parseFloat(
                    this.oModeloDeterministico.ct_almacenamiento
                ).toFixed(2);
                this.calculaCostoMantenimiento();
            } catch (e) {
                this.oModeloDeterministico.ct_almacenamiento = "";
            }
        },
        calculaCostoDepreciacion() {
            try {
                if (
                    this.oModeloDeterministico.precio_compra == "" ||
                    isNaN(parseFloat(this.oModeloDeterministico.precio_compra))
                ) {
                    throw new Error("El valor obtenido es no númerico");
                }
                this.oModeloDeterministico.c_depreciacion =
                    parseFloat(this.oModeloDeterministico.precio_compra) / 32;
                this.oModeloDeterministico.c_depreciacion = parseFloat(
                    this.oModeloDeterministico.c_depreciacion
                ).toFixed(2);
                this.calculaCostoMantenimiento();
            } catch (e) {
                this.oModeloDeterministico.c_depreciacion = "";
            }
        },
        calculaProcesamientoPedido() {
            try {
                if (
                    this.oModeloDeterministico.procesamiento_pedido == "" ||
                    isNaN(
                        parseFloat(
                            this.oModeloDeterministico.procesamiento_pedido
                        )
                    )
                ) {
                    this.oModeloDeterministico.procesamiento_pedido_calculado =
                        "";
                } else {
                    this.oModeloDeterministico.procesamiento_pedido_calculado =
                        parseFloat(
                            parseFloat(
                                this.oModeloDeterministico.procesamiento_pedido
                            ) / 24
                        ).toFixed(2);
                    this.calculaLeadtime();
                }
                this.$forceUpdate();
            } catch (e) {
                console.log(e);
                this.oModeloDeterministico.procesamiento_pedido_calculado = "";
            }
        },
        calculaLeadtime() {
            try {
                if (
                    this.oModeloDeterministico.procesamiento_pedido_calculado ==
                        "" ||
                    isNaN(
                        parseFloat(
                            this.oModeloDeterministico
                                .procesamiento_pedido_calculado
                        )
                    ) ||
                    this.oModeloDeterministico.fabricacion_productos == "" ||
                    isNaN(
                        parseFloat(
                            this.oModeloDeterministico.fabricacion_productos
                        )
                    ) ||
                    this.oModeloDeterministico.tiempo_transito == "" ||
                    isNaN(
                        parseFloat(this.oModeloDeterministico.tiempo_transito)
                    ) ||
                    this.oModeloDeterministico.inspeccion_control == "" ||
                    isNaN(
                        parseFloat(
                            this.oModeloDeterministico.inspeccion_control
                        )
                    )
                ) {
                    this.oModeloDeterministico.leadtime = "";
                } else {
                    this.oModeloDeterministico.leadtime =
                        parseFloat(
                            this.oModeloDeterministico
                                .procesamiento_pedido_calculado
                        ) +
                        parseFloat(
                            this.oModeloDeterministico.fabricacion_productos
                        ) +
                        parseFloat(this.oModeloDeterministico.tiempo_transito) +
                        parseFloat(
                            this.oModeloDeterministico.inspeccion_control
                        );
                }
            } catch (e) {
                console.log(e);
                this.oModeloDeterministico.leadtime = "";
            }
        },
        getPromedioRepuestos() {
            // if (this.oModeloDeterministico.repuesto_id != "") {
            axios
                .get("/admin/modelo_deterministicos/getPromedioRepuestos", {
                    params: {
                        repuesto_id: this.oModeloDeterministico.repuesto_id,
                    },
                })
                .then((response) => {
                    this.oModeloDeterministico.vp_rep =
                        response.data.valor_promedio;
                    this.oModeloDeterministico.cantp_rep =
                        response.data.cantidad_promedio;
                    this.oModeloDeterministico.costop_rep =
                        response.data.costo_promedio;
                });
            // } else {
            // this.oModeloDeterministico.vp_rep = "";
            // this.oModeloDeterministico.cantp_rep = "";
            // this.oModeloDeterministico.costop_rep = "";
            // }
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/modelo_deterministicos";

                if (this.accion == "edit") {
                    url =
                        "/admin/modelo_deterministicos/" +
                        this.oModeloDeterministico.id;
                    this.oModeloDeterministico["_method"] = "PUT";
                }

                for (const prop in this.oModeloDeterministico) {
                    if (this.oModeloDeterministico[prop] === "") {
                        delete this.oModeloDeterministico[prop];
                    }
                }
                axios
                    .post(url, this.oModeloDeterministico)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaModeloDeterministico();
                            this.$router.push({
                                name: "modelo_deterministicos.index",
                            });
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                                let mensaje = `<ul class="text-left">`;
                                for (let key in this.errors) {
                                    if (this.errors.hasOwnProperty(key)) {
                                        const value = this.errors[key];
                                        if (Array.isArray(value)) {
                                            value.forEach((error) => {
                                                mensaje += `<li><span>${error.trim()}</span></li>`;
                                            });
                                        }
                                    }
                                }
                                mensaje += `<ul/>`;
                                Swal.fire({
                                    icon: "error",
                                    title: "Completa el formulario",
                                    html: mensaje,
                                    showConfirmButton: true,
                                    confirmButtonColor: "#149FDA",
                                    confirmButtonText: "Aceptar",
                                });
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiaModeloDeterministico() {
            this.errors = [];
            this.oModeloDeterministico.num_identificacion = "";
        },
    },
};
</script>

<style>
.contenedor_md .form-group > input[readonly] {
    font-weight: bold;
    color: white;
    font-size: 1.2em;
    background: var(--secundario);
}
</style>
