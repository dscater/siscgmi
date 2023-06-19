<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <b-skeleton-wrapper
                        :loading="!oOrdenGenerada"
                        class="w-100"
                    >
                        <template #loading>
                            <b-skeleton-table
                                :rows="3"
                                :columns="3"
                                :table-props="{ bordered: true, striped: true }"
                            >
                            </b-skeleton-table>
                        </template>
                        <form v-if="oOrdenGenerada">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.repuesto_id,
                                        }"
                                        >Seleccionar Repuesto*</label
                                    >
                                    <el-select
                                        placeholder="Seleccionar Repuesto"
                                        class="w-100"
                                        :class="{
                                            'is-invalid': errors.repuesto_id,
                                        }"
                                        v-model="repuesto_id"
                                        filterable
                                        clearable
                                        @change="
                                            detectaRepuesto();
                                            calculaTotal();
                                        "
                                    >
                                        <el-option
                                            v-for="(
                                                item, index
                                            ) in listRepuestos"
                                            :key="index"
                                            :value="item.id"
                                            :label="item.full_name"
                                        ></el-option>
                                    </el-select>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.repuesto_id"
                                        v-text="errors.repuesto_id[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.stock_actual,
                                        }"
                                        >Stock actual
                                        <small>(Automático)</small>*</label
                                    >
                                    <el-input
                                        :class="{
                                            'is-invalid': errors.stock_actual,
                                        }"
                                        v-model="oRepuesto.stock_actual"
                                        readonly
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.stock_actual"
                                        v-text="errors.stock_actual[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.cantidad_requerida,
                                        }"
                                        >Cantidad requerida*</label
                                    >
                                    <input
                                        type="number"
                                        class="form-control"
                                        :class="{
                                            'is-invalid':
                                                errors.cantidad_requerida,
                                        }"
                                        v-model="cantidad_requerida"
                                        @change="calculaTotal"
                                        @keyup="calculaTotal"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.cantidad_requerida"
                                        v-text="errors.cantidad_requerida[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.precio,
                                        }"
                                        >Costo unitario
                                        <small>(Automático)</small>*</label
                                    >
                                    <el-input
                                        :class="{
                                            'is-invalid': errors.precio,
                                        }"
                                        v-model="oRepuesto.precio"
                                        readonly
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.precio"
                                        v-text="errors.precio[0]"
                                    ></span>
                                </div>

                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.total,
                                        }"
                                        >Total
                                        <small>(Automático)</small>*</label
                                    >
                                    <el-input
                                        :class="{
                                            'is-invalid': errors.total,
                                        }"
                                        v-model="total"
                                        readonly
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.total"
                                        v-text="errors.total[0]"
                                    ></span>
                                </div>
                                <div class="col-md-12">
                                    <button
                                        type="button"
                                        class="btn btn-primary btn-flat btn-block"
                                        :disabled="validaInfo"
                                        @click="agregarRepuesto"
                                    >
                                        <i class="fa fa-plus"></i> Agregar a la
                                        lista
                                    </button>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-md-12">
                                    <h4
                                        class="font-weight-bold text-center text-lg"
                                    >
                                        Lista de repuestos
                                    </h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Repuesto</th>
                                                <th>Costo unitario</th>
                                                <th>Cantidad requerida</th>
                                                <th>Total</th>
                                                <th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    oOrdenGenerada
                                                        .detalle_repuestos
                                                        .length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oOrdenGenerada.detalle_repuestos"
                                                    :key="index"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.repuesto
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>{{ item.costo }}</td>
                                                    <td>
                                                        {{
                                                            item.cantidad_requerida
                                                        }}
                                                    </td>
                                                    <td>{{ item.total }}</td>
                                                    <td>
                                                        <button
                                                            type="button"
                                                            class="btn btn-danger btn-xs"
                                                            @click="
                                                                eliminarRepuesto(
                                                                    index,
                                                                    item.id
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </template>
                                            <template v-else>
                                                <tr>
                                                    <td
                                                        colspan="6"
                                                        class="text-center font-italic text-gray"
                                                    >
                                                        NO SE AGREGÓ NINGÚN
                                                        REGISTRO
                                                    </td>
                                                </tr>
                                            </template>
                                            <tr>
                                                <td
                                                    colspan="4"
                                                    class="font-weight-bold text-right"
                                                >
                                                    TOTAL
                                                </td>
                                                <td class="font-weight-bold">
                                                    {{ sumaTotal }}
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </form>
                    </b-skeleton-wrapper>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cancelar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
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
        orden_trabajo: {
            type: Object,
            default: {
                id: 0,
                fecha_programada: "",
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                estado: "",
                orden_generada: {
                    id: 0,
                    archivo: "",
                    descripcion_documentacion: "",
                    comentario: "",
                    detalle_repuestos: [],
                    detalle_herramientas: [],
                    detalle_personals: [],
                },
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            this.oOrdenGenerada = null;
            if (newVal) {
                this.bModal = true;
                this.repuesto_id = "";
                this.total = 0;
                this.eliminados = [];
                this.oRepuesto = {
                    id: "",
                    stock_actual: 0,
                    precio: 0,
                };
                this.getOrdengenerada();
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return "REPUESTOS";
        },
        textoBoton() {
            return "Guardar cambios";
        },
        validaInfo() {
            if (
                this.repuesto_id &&
                this.cantidad_requerida &&
                this.cantidad_requerida > 0 &&
                this.cantidad_requerida <= this.oRepuesto.stock_actual
            ) {
                return false;
            }
            return true;
        },
        sumaTotal() {
            let sumatoria = 0;
            sumatoria = 0;
            if (this.oOrdenGenerada.detalle_repuestos.length > 0) {
                this.oOrdenGenerada.detalle_repuestos.forEach((elem) => {
                    sumatoria += parseFloat(elem.total);
                });
            }
            return sumatoria;
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oOrdenGenerada: null,
            listRepuestos: [],
            oRepuesto: {
                id: "",
                stock_actual: 0,
                precio: 0,
            },
            repuesto_id: "",
            cantidad_requerida: 0,
            total: 0,
            eliminados: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getRepuestos();
    },
    methods: {
        getRepuestos() {
            axios.get("/admin/repuestos").then((response) => {
                this.listRepuestos = response.data.repuestos;
            });
        },
        getOrdengenerada() {
            axios
                .get(
                    "/admin/orden_generadas/getByOrdenTrabajo/" +
                        this.orden_trabajo.id
                )
                .then((response) => {
                    this.oOrdenGenerada = response.data;
                });
        },
        detectaRepuesto() {
            if (this.repuesto_id != "") {
                this.oRepuesto = this.listRepuestos.filter((elem) => {
                    return elem.id == this.repuesto_id;
                })[0];
            } else {
                this.repuesto_id = "";
                this.oRepuesto = {
                    id: "",
                    stock_actual: 0,
                    precio: 0,
                };
            }
        },
        agregarRepuesto() {
            this.oOrdenGenerada.detalle_repuestos.push({
                id: 0,
                orden_generada_id: this.oOrdenGenerada.id,
                repuesto_id: this.repuesto_id,
                cantidad_requerida: this.cantidad_requerida,
                costo: this.oRepuesto.precio,
                total: this.total,
                repuesto: this.oRepuesto,
            });
            this.repuesto_id = "";
            this.detectaRepuesto();
            this.total = 0;
            this.cantidad_requerida = 0;
        },
        calculaTotal() {
            if (
                this.repuesto_id &&
                this.cantidad_requerida &&
                this.cantidad_requerida > 0 &&
                this.cantidad_requerida <= this.oRepuesto.stock_actual
            ) {
                this.total =
                    parseFloat(this.cantidad_requerida) *
                    parseFloat(this.oRepuesto.precio);
                this.total = parseFloat(this.total).toFixed();
            } else {
                this.total = 0;
            }
        },
        eliminarRepuesto(index, id) {
            if (id != 0) {
                this.eliminados.push(id);
            }
            this.oOrdenGenerada.detalle_repuestos.splice(index, 1);
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                if (this.eliminados.length > 0) {
                    this.oOrdenGenerada.eliminados = this.eliminados;
                }
                let url =
                    "/admin/detalle_repuestos/store/" + this.oOrdenGenerada.id;
                axios
                    .post(url, this.oOrdenGenerada)
                    .then((response) => {
                        this.enviando = false;
                        if (response.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            console.log(response.data);
                            this.$emit(
                                "envioModal",
                                response.data.orden_generada
                            );
                            this.limpiaModal();
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: response.data.message,
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
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaModal() {
            this.errors = [];
        },
    },
};
</script>

<style></style>
